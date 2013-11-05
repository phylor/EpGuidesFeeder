require 'net/http'

resource = Net::HTTP.new('epguides.com', 80)
headers,data = resource.get('/common/exportToCSV.asp?rage=8511')

print "HERE IS THE FILE CONTENT\n"
print data

print "\nHEADERS:\n"
headers.each do |key,val|
  print "#{key}: #{val[0..50]}\n"
end
print "Status code #{headers.code}, message #{headers.message}\n"
