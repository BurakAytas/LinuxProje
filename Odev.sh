#!/bin/bash

while [ 1 ]
do
var=$(zenity --list \
--height=300 \
--width=400 \
--title="Uygulama" \
--text="İşlem seçiniz!!" \
--column="İşlem" --column="Açıklama" \
KayıtEkle "Kullanıcı Ekle" \
KayıtAra "Kullanıcı Ara" \
KayıtListele "Kullanıcıları Görüntüle" \
KayıtSil "Kullanıcı Sil" \
Çıkış "Uygulamadan Çıkış Yap ")

i=0

if [ $var == "KayıtEkle" ]
then
	i=1
	ekle=$(zenity --entry --width=250 --height=150 --title="Kullanıcı Ekle" --text="Kullanıcı Giriniz : ")
	if [ $? = 0 ]
	then
	zenity --info --width=350 --height=200 --text="$ekle Adlı Kullanıcı Ekleme Başarılı"
		echo $ekle >> kayıt.txt
	else
		zenity --info --width=250 --height=150 --text="Kullanıcı Ekleme Başarısız oldu"
	fi
fi

if [ $var == "KayıtAra" ]
then
	i=1
	ara=$(zenity --entry --width=250 --height=150 --title="Kullanıcı Ara" --text="Kullanıcı Adını Giriniz :")
	if [ $? == 0 ]
        then
		kontrol=$(cat kayıt.txt | grep -w $ara)
		if [ $? == 0 ]
		then
			zenity --info --width=250 --height=150 --text "$ara Adlı Kullanıcı Bulundu"
			
		else
			zenity --info --width=250 --height=150 --text "$ara Adlı Kullanıcı Kayıtlarda Yok"
		fi
	else
		zenity --info --width=250 --height=150 --text "Arama Gerçekleşmedi"	
	fi

fi

if [ $var == "KayıtListele" ]
then
	i=1
	zenity --text-info --filename=kayıt.txt
fi

if [ $var == "KayıtSil" ]
then
	i=1
        sil=$(zenity --entry --width=250 --height=150 --title="Kullanıcı Sil" --text="Kullanıcı Adını Giriniz : ")
        if [ -z "$sil" ]
	then
		zenity --info --width=250 --height=150 --text "Silme İşlemi Gerçekleşmedi"
	else
		kontrol=$(cat kayıt.txt | grep -w $sil)
		if [ $? == 1 ]
		then
			zenity --info --width=250 --height=150 --text "$sil Adlı Kullanıcı Listede Bulunmamaktadır"
		else 
	
			grep -v -w $sil  kayıt.txt > tmpfile && mv tmpfile kayıt.txt
			zenity --info --width=250 --height=150 --text="$sil Adlı Kullanıcı Silinmiştir."
		fi
	fi
	
		
fi

if [ $var == "Çıkış" ]
then		
	zenity --question \
  	--title="Soru" \
  	--width=250 --height=150\
  	--text="Çıkmak istediğinizden emin misiniz?"
  	if [ $? = 0 ]; then
  	zenity --info --width=250 --height=150 --text="Çıkış Gerçekleştirildi."
  	exit
  	fi

elif [ $i == 0 ]
then
	zenity --question \
  	--title="Soru" \
  	--width=250 --height=150\
  	--text="Çıkmak istediğinizden emin misiniz?"
  	if [ $? = 0 ]; then
  	zenity --info --width=250 --height=150 --text="Çıkış Gerçekleştirildi."
  	exit
  	fi
fi

done