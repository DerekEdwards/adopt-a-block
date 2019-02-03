class MailchimpService
  def subscribe email
    {
        "email_address": email,
        "status": "subscribed",
        "merge_fields": {
            "FNAME": "Urist",
            "LNAME": "McVankab"
        }
    }
  end
end