# SWEET DREAMS
`
his application allows users to register and leave a description of their dream. Users can read dreams, leave comments on other users' dreams, and make their dreams private.
`

---
## Main entities
### ~ User :
   *  user can be admin or normal user
### ~ Deram :
   *  dreams can be private or public
### ~ Comment :
  *  Comments can onlya
### ~ Category :
  *  categories can only be created by the admin
### ~ Reply :
  *  can only be left by registered users
### ~ Tag
___
## Opportunities for the user registered users

### ~ User :
```
   * stop your sleep
   * Editing self dreams
   * Make your dreams private
   * Edit your dreams
   * Enjoy your dreams
```
___

<<<<<<< Updated upstream
## To run:
---
```rb
  bundle exec rails db:create db:migrate db:seed
```
---

* ## [mailcatcher](https://mailcatcher.me/)
```
  sudo gem install mailcatcher

  mailcatcher
```
---

* ## [installation instructions redis](https://www.arubacloud.com/tutorial/how-to-install-and-configure-redis-on-ubuntu-20-04.aspx)
```
  sudo apt install redis-server
  bundle exec sidekiq
  bundle exec rails s
=======
### To run:

```rb
bundle exec rails db:create db:migrate db:seed
```
---
* ## [mailcatcher](https://mailcatcher.me/)
```
     sudo gem install mailcatcher
     mailcatcher
```
---
* ## [installation instructions redis](https://www.arubacloud.com/tutorial/how-to-install-and-configure-redis-on-ubuntu-20-04.aspx)

```
    sudo apt install redis-server
    bundle exec sidekiq
    bundle exec rails s
>>>>>>> Stashed changes
```
---
