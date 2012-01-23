if Rails.env.production?
  Stripe.api_key = "NAExLd4KaYKZOgGwghofgp4h6oQb1yhT"
  STRIPE_PUBLIC_KEY = "pk_bbFEct0YyZO6Yx1a2zGyxmGbSyfRr "
else
  Stripe.api_key = "1Km8QpFQOV3eErswXLOvaS6UgRIKH4Uc"
  STRIPE_PUBLIC_KEY = "pk_vWRJu7rE7SmniE08VPTbET4lDUS8f" 
end