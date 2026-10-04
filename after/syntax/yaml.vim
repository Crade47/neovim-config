if expand('%:t') !~# '\.ya\?ml\.tftpl$'
    finish
endif

syntax region yamlTftplInterpolation start=/\${/ end=/}/ keepend containedin=ALL
syntax region yamlTftplDirective start=/%{/ end=/}/ keepend containedin=ALL

highlight default link yamlTftplInterpolation Identifier
highlight default link yamlTftplDirective PreProc