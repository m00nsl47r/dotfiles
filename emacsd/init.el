(print "hello christopher.")

; add zsh files to sh minor mode for syntax hilighting etc
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

					; (add-to-list 'tramp-default-user-alist
					;'("ssh" "*\\.whatbox\\.ca\\'" m00nsl47r))

					; (server-start)
;;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tsdh-light)))
 '(tramp-default-host "HOME-arch" nil (tramp))
 '(tramp-default-method "ssh" nil (tramp))
 '(tramp-default-user "chrstfer" nil (tramp)))

;;; 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 98 :width normal)))))


(defun sysd-stop-emacs(&optional display)
  "This function is used for controlling the way systemctl stop --user emacs ends the emacs daemon session. It should be called using emacsclient -e '(sysd-stop-emacs)', which is the value of the command called by systemd when stopping the userspace emacs daemon. It checks if any buffers have been modified, and whether there are active frames/clients; if so it will prompt the user"
  (let (new-frame modified-buffers active-clients-or-frames)

    ; Check if there modified buffers or active clients or frames.
    (setq modified-buffers (modified-buffers-exist))
    (setq active-clients-or-frames ( or (> (length server-clients) 1)
					(> (length (frame-list)) 1)))

    ; Create a new frame if prompts are needed.
    (when (or modified-buffers active-clients-or-frames)
      (when (not (eq window-system 'x))
	(message "Initializing x windows system.")
	(x-initialize-window-system))
      (when (not display) (setq display (getenv "DISPLAY")))
      (message "Opening frame on display: %s" display)
      (select-frame (make-frame-on-display display '((window-system . x)))))

    ; Save the current frame.  
    (setq new-frame (selected-frame))


    ; When displaying the number of clients and frames: 
    ; subtract 1 from the clients for this client.
    ; subtract 2 from the frames this frame (that we just created) and the default frame.
    (when ( or (not active-clients-or-frames)
	       (yes-or-no-p (format "There are currently %d clients and %d frames. Exit anyway?" (- (length server-clients) 1) (- (length (frame-list)) 2))))
      
      ; If the user quits during the save dialog then don't exit emacs.
      ; Still close the terminal though.
      (let((inhibit-quit t))
             ; Save buffers
	(with-local-quit
	  (save-some-buffers)) 
	      
	(if quit-flag
	  (setq quit-flag nil)
          ; Kill all remaining clients
	  (progn
	    (dolist (client server-clients)
	      (server-delete-client client))
		 ; Exit emacs
	    (kill-emacs)))))

    ; If we made a frame then kill it.
    (when (or modified-buffers active-clients-or-frames) (delete-frame new-frame))))


(defun modified-buffers-exist() 
  "This function will check to see if there are any buffers that have been modified.  It will return true if there are and nil otherwise. Buffers that have buffer-offer-save set to nil are ignored."
  (let (modified-found)
    (dolist (buffer (buffer-list))
      (when (and (buffer-live-p buffer)
		 (buffer-modified-p buffer)
		 (not (buffer-base-buffer buffer))
		 (or
		  (buffer-file-name buffer)
		   (progn
		     (set-buffer buffer)
		     (and buffer-offer-save (> (buffer-size) 0)))))
	(setq modified-found))
      modified-found)))
