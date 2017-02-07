# prettier-eslint-emacs
Auto-format current buffer with [prettier-eslint](https://github.com/kentcdodds/prettier-eslint-cli)

## Usage

`M-x prettier-eslint`

To automatically format after saving:

```eslip
(add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t)))
(add-hook 'react-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t)))
```

In Spacemacs add the above to your `dotspacemacs/user-config`

Otherwise:

```eslip
(eval-after-load 'js2-mode
  '(add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'prettier-eslint nil t))))
```

## LICENSE
MIT
