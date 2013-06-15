#!/usr/bin/env ruby

require "test/unit"

class User
    
    def setName(name)
      @name = name
    end
    
    def getName()
      @name
    end  
    
    def newPassword
      password = (0...6).map{(65+rand(26)).chr}.join
    end  
    
    
    require 'resolv'
    def email_validate(email)
      domain = email.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
          @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      @mx.size > 0 ? true : false
    end  

    
end



class TestUser < Test::Unit::TestCase
    
    def test_initialize
        assert_not_nil(User.new)
    end


    def test_get_user_name
	user = User.new
	user.setName('Andre Cardoso')
	assert_equal('Andre Cardoso', user.getName(), 'Não conseguiu setar ou resgatar o nome definido')
    end
    
    
    
    def test_get_new_password
      user = User.new
      assert_not_nil(user.newPassword)
    end   
    
    
    def test_valid_email
      user = User.new
      assert(user.email_validate('andrecardosodev@gmail.com'), 'Não validou o email')
    end
    
    
    def test_invalid_email
      user = User.new
      assert_equal(false, user.email_validate('asdas@asds'), 'Validou o email com erro')
   end   
    
end 
