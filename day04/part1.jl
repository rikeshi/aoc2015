using Nettle

h = Hasher("MD5")
secret = "bgvyzdsv"
i = 0
while true
  global secret, i
  input = secret * string(i)
  update!(h, input)
  if startswith(hexdigest!(h), "00000")
    println(i)
    break
  end
  i += 1
end
