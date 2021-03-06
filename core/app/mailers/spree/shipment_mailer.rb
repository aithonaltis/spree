module Spree
  class ShipmentMailer < ActionMailer::Base

    def money(amount)
      Spree::Money.new(amount).to_s
    end
    helper_method :money

    def from_address
      MailMethod.current.preferred_mails_from
    end

    def shipped_email(shipment, resend = false)
      @shipment = shipment
      subject = (resend ? "[#{t(:resend).upcase}] " : '')
      subject += "#{Spree::Config[:site_name]} #{t('shipment_mailer.shipped_email.subject')} ##{shipment.order.number}"
      mail(to: shipment.order.email,
           from: from_address,
           subject: subject)
    end
  end
end
