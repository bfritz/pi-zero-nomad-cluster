# dnsmasq-formula

Purpose of formula. Include a short description of what the formula does.


Describe in a readable form the states this formula supports with examples how to use those states.


Install and setup brew:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
brew install cask
brew cask install vagrant
```

```
cd <formula dir>
bundle install
```
or
```
sudo gem install test-kitchen
sudo gem install kitchen-vagrant
sudo gem install kitchen-salt
```

Run a converge on the default configuration:
```
kitchen converge default
```
