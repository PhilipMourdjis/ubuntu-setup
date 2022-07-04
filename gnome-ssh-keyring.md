Create ssh keys
```
mkdir .ssh
cd .ssh
ssh-keygen -t rsa
```

should produce:

```
~/.ssh/id_rsa     <---- private key
~/.ssh/id_rsa.pub <---- public key
```

Add to keyring to save passwords for you
```
ssh-add ~/.ssh/id_rsa
```

Create `~/.ssh/config`
```
# Public
Host github.com-pub
	HostName github.com
	User git
	IdentityFile ~/.ssh/github_public
# External
Host github.com-ext
	HostName github.com
	User git
	IdentityFile ~/.ssh/github_external
```