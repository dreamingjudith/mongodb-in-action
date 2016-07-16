# How to use TweetArchiver

First of all, you have to install gems

- mongo (2.2.6)
- twitter (5.16.0)
- sinatra (1.4.7)

And then, you have to collect tweets with typing below command in your shell.
```
ruby update.rb
```
You can change search keyword with TAGS in `config.rb`.

After making archive in your MongoDB, just run your application.
```
ruby viewer.rb
```
You can see the result in `http://localhost:4567`.
