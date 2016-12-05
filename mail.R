library(mailR)
# https://github.com/rpremraj/mailR
send.mail(from = from,
          to = to,
          subject = subject,
          body = msg,
          authenticate = TRUE,
          smtp = list(host.name = "smtp.office365.com", port = 587,
                      user.name = "xxx@domain.com", passwd = "xxx", tls = TRUE))
