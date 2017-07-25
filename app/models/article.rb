class Article < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, presence: true,
                    length: { minimum: 5 }


                      def full_street_address
                        [street, city, state].join(', ')
                      end

                    geocoded_by :address   # can also be an IP address
                    after_validation :geocode          # auto-fetch coordinates

                    reverse_geocoded_by :latitude, :longitude
                    after_validation :reverse_geocode  # auto-fetch address


include ElasticRansack



                                          has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

                                          validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


                                          translates :title, :text

                                          def cache_key
                                            super + '-' + Globalize.locale.to_s
                                          end




end
