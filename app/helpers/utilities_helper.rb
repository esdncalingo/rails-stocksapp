module UtilitiesHelper

  def random_emoji 
    random_emoji = ["(·.·)", "(·_·)", "(>_<)","(o_o)", "(^_^)b","(o^^)o",
      "(^-^*)","(^Д^)","(;-;)","┬─┬ノ( º _ ºノ)", "(╯°□°)╯︵ ┻━┻","(┛ಠ_ಠ)┛彡┻━┻",
      "┳━┳ ヽ(ಠل͜ಠ)ﾉ","(┛◉Д◉)┛彡┻━┻"
    ]
    random_emoji.sample
  end
  
end