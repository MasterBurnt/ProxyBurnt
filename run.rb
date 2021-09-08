#!/usr/bin/ruby
#
# @name   : ProxyBurnt
# @url    : http://github.com/MasterBurnt
# @author : MasterBurnt 
require 'httparty'

#color 
class String
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def brown;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
end

#banner
def banner()
    system('clear')
    puts"""
                    
          ▇▇▇◤▔▔▔▔▔▔▔◥▇▇▇ 
          ▇▇▇▏◥▇◣┊◢▇◤▕▇▇▇
          ▇▇▇▏▃▆▅▎▅▆▃▕▇▇▇
          ▇▇▇▏╱▔▕▎▔▔╲▕▇▇▇
          ▇▇▇◣◣▃▅▎▅▃◢◢▇▇▇
          ▇▇▇▇◣◥▅▅▅◤◢▇▇▇▇
          ▇▇▇▇▇◣╲▇╱◢▇▇▇▇▇
""".green
    puts"""
  ░P░░R░░O░░X░░Y░░B░░U░░R░░N░░T░

""".red
end
banner()

#required
def input_1(type)
    if type == "1"
        return "http"
    elsif type == "2"
        return "https"
    elsif type == "3"
        return "socks4"
    elsif type == "4"
        return "socks5"
    elsif type == "0"
        return exit
    else
        system('clear')
        banner()
        out1()
    end
end 

#optional
def input_2(anon)
    if anon == "1" 
        return "anonymous"
    elsif anon == "2" 
        return "elite"
    elsif anon == "3" or anon == "" 
        return ""
    elsif anon == "0" 
        return exit
    else
        system('clear')
        banner()
        out2
    end
end 

def out1()
    puts '''
$required$
    
[1] http
[2] https
[3] socks4
[4] socks5
[0] exit
'''.blue   
    puts '[?] Please select an item : '.brown
    type = gets.chomp.strip
    type = input_1(type)
end
def out2()
    banner()
    puts '''
$optional$

[1] anonymous
[2] elite
[3] you can skip this step (enter or 3)
[0] exit
'''.blue
    puts'[?] Please select an item : '.brown
    anon = gets.chomp.strip
    anon = input_2(anon)
end

a = out1()
b = out2()

#Api
api = "https://www.proxy-list.download/api/v1/get"

#outApi
if b == ""
    api = "#{api}?type=#{a}"
else 
    api = "#{api}?type=#{a}&anon=#{b}"
end

#request - t : 5
begin
    response = HTTParty.get(api,timeout: 5)
rescue
    system('clear')
    puts """Please check your internet connection.\nAlso, if your country is under sanctions,\nturn on vpn and try again!
    """.red
    sleep(8)
    system('clear')
    exit 1
end

#Conditions 
ok = response.body if response.code == 200
if ok == ""
    puts "it is empty!".red
    exit
else
    banner()
    puts ok
end 

#saved
begin
    Dir.mkdir('History')
    Dir.chdir('History')
rescue 
    Dir.chdir('History')
end 

f = File.open(a+".txt","wt")
f.write ok
f.close
puts "\nThe file was saved in the folder : History\nname : #{a}.txt".green

