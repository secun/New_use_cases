#How to access GMail
# https://www.rdocumentation.org/packages/gmailr/versions/0.7.1
# https://medium.com/airbnb-engineering/using-googlesheets-and-mailr-packages-in-r-to-automate-reporting-c09579e0377f
# https://github.com/jennybc/send-email-with-r
install.packages('mailR')
library(mailR)

#Setup
use_secret_file("secun_email.json")  #Line added to gitiignore

test_email <- gm_mime(
  To = "secundino.sexto@gmail.com",
  From = "No te lo digo",
  Subject = "Prueba",
  body <- "Hi, %s.

            Your mark for %s is %s.

            Thanks for participating in this film!"
)

gm_send_message(test_email)


this_hw <- "The Fellowship Of The Ring"
email_sender <- 'Peter Jackson <peter@tolkien.example.org>' # your Gmail address
