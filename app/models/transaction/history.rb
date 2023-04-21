class Transaction
  class History
    def self.show(user_id, kind) 

      user = User.find(user_id)  
      if (kind == "All" or kind == nil)   
        user.transactions       
      else 
        user.transactions.where(kind: kind)
      end
    end
  end
end 
