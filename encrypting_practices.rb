require "openssl"
require 'digest/sha2'
require 'base64'
require 'pry'
require 'time'

#a good way to be secure, is to be able to time how long did it take the random six digits and issuing processor number to match.
#then use that time to be the key to decrypt the number of the random six digits of the card.


#                                                           CREDIT-CARD INPUT

puts "\t\t\t\t\t\t\tGood Evening!"

puts
sleep 5

puts "\t\t\t\t\tThank you for signing up to our Bank!"

puts
sleep 5

puts "\t\t\t\t\t\tEnjoy your New Credit Card"

puts
sleep 5
puts "Please enter you card to Activate it (16 digits): "
credit_card_number = ""
puts

while credit_card_number.length != 16
    puts "It has to be equal to 16 digit or letters: "
    credit_card_number = rand(1111111111111111..9999999999999999).to_s
end
puts

sleep 5
#                                                           EXPIRATION DATE
puts "Expiration date: "
expiration_date = ""
puts

while expiration_date.length != 4
    puts "Expiration data should be formatted as (mm/yy)"
    expiration_date = rand(1111..9999).to_s
end
puts
sleep 5
#                                                           CVV Number
puts "What is the CVV of your card? "
cvv = ""
puts

while cvv.length != 3
    puts "CVV number should be 3 digits number"
    cvv = rand(111..999).to_s
end
puts
sleep 5
#                                                           PASSKEY
puts "Create a passkey: "
passkey = ""
#passkey + datetime == new authantication number(Random Number)
while passkey.length != 11
    puts "It has to be equal to 11 digit: "
    passkey = rand(11111111111..99999999999).to_s
end
sleep 5
puts
puts
credit_card_number.to_i
puts "Credit Card #: #{credit_card_number}"
puts
puts
expiration_date.to_i
puts "Expiration Data: #{expiration_date}"
puts
puts
cvv.to_i
puts "Card CVV #: #{cvv}"
puts
puts
#make sure this becomes a number down the code.
passkey
puts "Passkey: ", passkey
puts

#                                                           CARD INFO.
puts "Processing..."
puts
sleep 5
puts
puts "Processing..."
puts
sleep 5
puts
puts "Processing..."
puts
sleep 5
puts
puts "Processing..."
puts
sleep 5
puts

puts "This is the Card Information: "
puts
puts "Credit Card: #{credit_card_number}"
puts "Expitation: #{expiration_date}"
puts "CVV: #{cvv}"
puts "Passkey: #{passkey}"
puts
puts
puts "\t\t\t\t\t\t\t\tVirtual Credit Card Generator"

#                                                            CARD Number- Select to Random

bin_bank = credit_card_number[0..5].to_i
personal_information_number = credit_card_number[6..8].to_i
six_digit_card_to_random = credit_card_number[9..14].to_i
last_digit_card = credit_card_number[15].to_i
random = Random.new
random_six_digits = random.rand(six_digit_card_to_random)
#number of time that will be generating.
time_changing = 0

algoritmo = "AES-256-CBC"
digest = Digest::SHA256.new

#                                                           BOTH #'s are changing in real Time, even if the user does not buy anything
while true && time_changing < 7
    sleep 5

#                                                           CARD WHEN ACTIVATED/USED

    tiempo = Time.now.to_i.to_s
    numero_desconosido = rand(six_digit_card_to_random).to_s

    #here is where I used the Passkey set by the user, and the random should belong to the 1st Stage.

        customer_passkey = digest.update("#{passkey}")
        customer_passkey = customer_passkey.digest
        customer_random_passkey = OpenSSL::Cipher::Cipher.new(algoritmo).random_key

       iv_for_six_digit_card = OpenSSL::Cipher::Cipher.new(algoritmo).random_iv
        iv_for_time_card = OpenSSL::Cipher::Cipher.new(algoritmo).random_iv

        #Customer  random and  key base 64
        six_digit_key64 = [customer_passkey, customer_random_passkey].pack('m')
        # puts six_digit_key64
        # Base64 decode the card_six_digits
        # puts "Six Digit card retrieved from base64"
        # p six_digit_key64.unpack('m')[0]
        raise 'Six Digit Card Error' if(customer_passkey.nil? && customer_random_passkey or customer_passkey.size != 32 && customer_random_passkey !=32 )

        # Now we do the actual setup of the cipher
        secured_encrypted_card = OpenSSL::Cipher::Cipher.new(algoritmo)
        secured_encrypted_card.encrypt
        secured_encrypted_card.key = customer_passkey && customer_random_passkey
        secured_encrypted_card.iv = iv_for_six_digit_card && iv_for_time_card

#we can separate each number later so we can
        cipher = secured_encrypted_card.update("#{tiempo}\n")
        cipher << secured_encrypted_card.final

        cipher2 = secured_encrypted_card.update("#{numero_desconosido}\n")
        cipher2 << secured_encrypted_card.final

        # cipher3 = secured_encrypted_card.update("#{customer_passkey}\n")
        # cipher3 << secured_encrypted_card.final

        # cipher4 = secured_encrypted_card.update("#{customer_random_passkey}\n")
        # cipher4 << secured_encrypted_card.final

        # cipher5 = secured_encrypted_card.update("#{passkey}\n")
        # cipher5 << secured_encrypted_card.final

        card_six_digits = cipher2, cipher

    #separate both values inside card six digits

    cipher_digits_generated = card_six_digits.values_at(0).collect {|number| number.to_s}*("").to_i
    cipher_time_generated = card_six_digits.values_at(1)*("").to_i




    # Issuing Processor activates when CREDIT CARD ACTIVATES
     ip_pass_random_passkey = rand(0..99999999999).to_s

    tiempo_del_pocessador = Time.now.to_i.to_s
    numero_desconosido_del_procesador = rand(six_digit_card_to_random).to_s

    #here is where I used the Passkey set by the user, and the random should belong to the 1st Stage.

        proccessor_passkey = digest.update("#{ip_pass_random_passkey}")
        proccessor_passkey = OpenSSL::Cipher::Cipher.new(algoritmo).random_key

        iv_for_six_digit_proccesor = OpenSSL::Cipher::Cipher.new(algoritmo).random_iv
        iv_for_time_proccesor = OpenSSL::Cipher::Cipher.new(algoritmo).random_iv


        #Customer  random and  key base 64
        proccesor_six_digit_key64 = [proccessor_passkey].pack('m')
        # puts proccesor_six_digit_key64
        # Base64 decode the card_six_digits
        # puts "Six Digit card retrieved from base64"
        # p proccesor_six_digit_key64.unpack('m')[0]
        raise 'Six Digit Card Error' if(proccessor_passkey.nil? or proccessor_passkey.size !=32)

        # Cipher config
        secured_encrypted_processor_digits = OpenSSL::Cipher::Cipher.new(algoritmo)
        secured_encrypted_processor_digits.encrypt
        secured_encrypted_processor_digits.key = proccessor_passkey
        secured_encrypted_processor_digits.iv = iv_for_time_proccesor && iv_for_six_digit_proccesor

#we can separate each number later so we can
        cipher_proccessor = secured_encrypted_processor_digits.update("#{tiempo_del_pocessador}\n")
        cipher_proccessor << secured_encrypted_processor_digits.final

        cipher_proccessor2 = secured_encrypted_processor_digits.update("#{numero_desconosido_del_procesador}\n")
        cipher_proccessor2 << secured_encrypted_processor_digits.final

        cipher_proccessor3 = secured_encrypted_processor_digits.update("#{proccessor_passkey}\n")
        cipher_proccessor3 << secured_encrypted_processor_digits.final

        cipher_proccessor4 = secured_encrypted_processor_digits.update("#{ip_pass_random_passkey}\n")
        cipher_proccessor4 << secured_encrypted_processor_digits.final

        numero_desconosido_del_procesador  = cipher_proccessor, cipher_proccessor2

    #separate both values inside card six digits

    cipher_proccesor_digits_generated = numero_desconosido_del_procesador.values_at(0)*("").to_i
    cipher_proccesor_time_generated = numero_desconosido_del_procesador.values_at(1)*("").to_i

    time_changing += 1

    puts "Here are the encrypted numbers generated at the same time: "
    puts "Six Digit Card: #{bin_bank} #{personal_information_number} #{cipher_digits_generated}, Time: #{cipher_time_generated}"
    puts "-------------------------------------------"
    puts "Issuing: #{cipher_proccesor_digits_generated}, Time: #{cipher_proccesor_time_generated}"
    puts "-------------------------------------------"

    cipher_proccessor = secured_encrypted_processor_digits.update("#{tiempo_del_pocessador}\n")


end

        cipher64_blah = [cipher2].pack('m')
        revertir_cipher_proccesor = OpenSSL::Cipher::Cipher.new(algoritmo)
        revertir_cipher_proccesor.decrypt
        revertir_cipher_proccesor.key = customer_passkey && customer_random_passkey
        revertir_cipher_proccesor.iv = iv_for_six_digit_card && iv_for_time_card
        revelar_la_encripcion_de_six_digits = revertir_cipher_proccesor.update(cipher64_blah.unpack('m')[0])
        revelar_la_encripcion_de_six_digits << revertir_cipher_proccesor.final
puts

#                                                   First Stage
sleep 5

balance = 330
puts "Let's pretend we are buying a product at the store"
puts
sleep 4
puts "What are you buying today? "
product = gets.chomp

puts "Payment"
payment = gets.chomp
sleep 3
puts "The last digits generated are valid for that purchase only, and only be validated for one minute"

puts
puts "Proccesing the transaction, it should have an ID."
puts
puts "Sending the request to the 1st Router"
credit_card_number_empty = "#{bin_bank}-#{cipher_proccesor_digits_generated}-#{last_digit_card}"

sleep 3

all_encrypted_account_card_to_pass = cipher, cipher_digits_generated, cipher_time_generated, credit_card_number_empty

#validate if there are all numbers validated. else it will reject the transaction
if all_encrypted_account_card_to_pass.count == 4

        cipher64 = [cipher].pack('m')
        revertir_cipher = OpenSSL::Cipher::Cipher.new(algoritmo)
        revertir_cipher.decrypt
        revertir_cipher.key = customer_passkey && customer_random_passkey
        revertir_cipher.iv = iv_for_six_digit_card && iv_for_time_card
        revelar_la_encripcion = revertir_cipher.update(cipher64.unpack('m')[0])
        revelar_la_encripcion << revertir_cipher.final

        # cipher64_proccesor = [cipher_proccessor].pack('m')
        # revertir_cipher_proccesor = OpenSSL::Cipher::Cipher.new(algoritmo)
        # revertir_cipher_proccesor.decrypt
        # revertir_cipher_proccesor.key = proccessor_passkey
        # revertir_cipher_proccesor.iv = iv_for_time_proccesor && iv_for_six_digit_proccesor
        # revelar_la_encripcion_cipher_processor = revertir_cipher_proccesor.update(cipher64_proccesor.unpack('m')[0])
        # revelar_la_encripcion_cipher_processor << revertir_cipher_proccesor.final

        if revelar_la_encripcion
            puts "#{revelar_la_encripcion}"
        end

#     puts credit_card_number_empty
#     puts
#     puts "I got your numbers on time"
#     puts
#     puts "Store X, what am I going to do with this empty number? #{credit_card_number_empty} (decrypted)"
#     answer = gets.chomp
#         if answer == "decrypted"
#             if
#             puts "Validating numbers..."
#             sleep 3
#             puts "Got it, the number are: \n"
#             puts numero_desconosido_del_procesador.values_at(1)*("")
#             puts numero_desconosido_del_procesador.values_at(1)*("")

#             puts "Decrypting the numbers..."
#             sleep 3
#             cipher64 = [cipher].pack('m')
#             revertir_cipher = OpenSSL::Cipher::Cipher.new(algoritmo)
#             revertir_cipher.decrypt
#             revertir_cipher.key = customer_passkey && customer_random_passkey
#             revertir_cipher.iv = iv_for_six_digit_card && iv_for_time_card
#             revelar_la_encripcion = revertir_cipher.update(cipher64.unpack('m')[0])
#             revelar_la_encripcion << revertir_cipher.final

#             cipher64 = [cipher_proccessor].pack('m')
#             revertir_cipher2 = OpenSSL::Cipher::Cipher.new(algoritmo)
#             revertir_cipher2.decrypt
#             revertir_cipher2.key = customer_passkey && customer_random_passkey
#             revertir_cipher2.iv = iv_for_six_digit_card && iv_for_time_card
#             revelar_la_encripcion2 = revertir_cipher2.update(cipher64.unpack('m')[0])
#             revelar_la_encripcion2 << revertir_cipher2.final
# binding.pry
#             puts "Here are the real numbers: "
#             puts "#{revelar_la_encripcion}, #{revelar_la_encripcion2}"

#             puts "now This number is validated only for 6 seconds"

#         else
#             puts "Something Happend, I am not accepting this number"
#         end
end
    puts revelar_la_encripcion_de_six_digits

sleep 5

puts "The Issuing Proccesor should be able to recieve the id"
