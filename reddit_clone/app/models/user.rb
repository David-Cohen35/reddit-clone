class User < ApplicationRecord

    validates :username, :session_token, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    attr_reader :password

    after_initialize :ensure_session_token!

    has_many :subs, 
    foreign_key: :moderator_id,
    class_name: :Sub 

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token!
        self.update!(session_token: User.generate_session_token!)
        self.session_token
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return user if user && user.is_password?(password)
        nil 
    end

    def is_password?(password)
        digest = BCrypt::Password.new(self.password_digest)
        digest.is_password?(password)
    end


    private

    def self.generate_session_token!
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token!
        self.session_token ||= User.generate_session_token!
    end

end
