﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// (с) Tolkachev Pavel, 2020
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьВидимостьПараметров();
	
	Если НаборКонстант.ИспользоватьСканерШтрихкодовAndroid Тогда
		
		УстройствоИспользуется = (глПараметрыСканераШтрихкодовAndroid.Сканер <> Неопределено);
		Если УстройствоИспользуется Тогда
			Элементы.Страницы.ТекущаяСтраница = Элементы.УстройствоИспользуется;
		Иначе
			ОбновитьИнформациюОДрайвере();
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИспользоватьСканерШтрихкодовAndroidПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	МенеджерСканераШтрихкодовAndroidКлиент.УстановитьПараметрыСканера();
	
	УстановитьВидимостьПараметров();
	
	Если НаборКонстант.ИспользоватьСканерШтрихкодовAndroid Тогда
		ОбновитьИнформациюОДрайвере();
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ActionNameПриИзменении(Элемент)
	
	УстановитьПараметрСканера("ActionName", ActionName);
	
КонецПроцедуры

&НаКлиенте
Процедура ExtraDataПриИзменении(Элемент)
	
	УстановитьПараметрСканера("ExtraData", ExtraData);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьДрайвер(Команда)
	
	Оповещение = Новый ОписаниеОповещения("УстановкаДрайвераЗавершение", ЭтотОбъект);
	МенеджерСканераШтрихкодовAndroidКлиент.НачатьУстановкуДрайвера(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановкаДрайвераЗавершение(ДопПараметры) Экспорт
	
	ОбновитьИнформациюОДрайвере();
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = НСтр("ru='Установка драйвера завершена.'");
	Сообщение.Сообщить();
	
КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьИнформациюОДрайвере()
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.ДрайверПолучениеИнформации;
	
	Оповещение = Новый ОписаниеОповещения("ПолучениеДрайвераЗавершение", ЭтотОбъект);
	МенеджерСканераШтрихкодовAndroidКлиент.НачатьПодключениеДрайвера(Оповещение);
	
КонецПроцедуры 

&НаКлиенте
Процедура ПолучениеДрайвераЗавершение(Успешно, ДопПараметры) Экспорт
	
	ИзмененаКонстантаДрайверУстановлен = Ложь;
	
	Если Успешно Тогда
		
		Элементы.Страницы.ТекущаяСтраница = Элементы.ДрайверУстановлен;
		
		глПараметрыСканераШтрихкодовAndroid.Свойство("ActionName", ActionName);
		глПараметрыСканераШтрихкодовAndroid.Свойство("ExtraData", ExtraData);
		
		Если Не НаборКонстант.ДрайверСканераШтрихкодовAndroidУстановлен Тогда
			НаборКонстант.ДрайверСканераШтрихкодовAndroidУстановлен = Истина;
			ИзмененаКонстантаДрайверУстановлен = Истина;
		КонецЕсли; 
		
	Иначе
		
		Элементы.Страницы.ТекущаяСтраница = Элементы.ДрайверНеУстановлен;
		
		Если НаборКонстант.ДрайверСканераШтрихкодовAndroidУстановлен Тогда
			НаборКонстант.ДрайверСканераШтрихкодовAndroidУстановлен = Ложь;
			ИзмененаКонстантаДрайверУстановлен = Истина;
		КонецЕсли; 
		
	КонецЕсли; 
	
	Если ИзмененаКонстантаДрайверУстановлен Тогда
		КонстантаИмя = СохранитьЗначениеРеквизита("НаборКонстант.ДрайверСканераШтрихкодовAndroidУстановлен");
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
		
		МенеджерСканераШтрихкодовAndroidКлиент.УстановитьПараметрыСканера();
	КонецЕсли; 
	
КонецПроцедуры 

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент)
	
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	
КонецПроцедуры 

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьДанным);
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	Префикс = "НаборКонстант.";
	КонстантаИмя = Сред(РеквизитПутьКДанным, СтрДлина(Префикс) + 1);
	
	КонстантаМенеджер = Константы[КонстантаИмя];
	КонстантаЗначение = НаборКонстант[КонстантаИмя];
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаКлиенте
Процедура УстановитьВидимостьПараметров()
	
	Элементы.Страницы.Видимость = НаборКонстант.ИспользоватьСканерШтрихкодовAndroid;
	
КонецПроцедуры 

&НаКлиенте
Процедура УстановитьПараметрСканера(ИмяПараметра, ЗначениеПараметра)
	
	глПараметрыСканераШтрихкодовAndroid.Вставить(ИмяПараметра, ЗначениеПараметра);
	
	СохранитьПараметрыСканера();
	
	Оповестить("Запись_НаборКонстант", Новый Структура, "ПараметрыСканераШтрихкодовAndroid");
	
КонецПроцедуры 

&НаСервере
Процедура СохранитьПараметрыСканера()
	
	ПараметрыСканера = Новый Структура;
	ПараметрыСканера.Вставить("ActionName", ActionName);
	ПараметрыСканера.Вставить("ExtraData", ExtraData);
	
	ПараметрыСканераХранилище = Новый ХранилищеЗначения(ПараметрыСканера);
	Константы.ПараметрыСканераШтрихкодовAndroid.Установить(ПараметрыСканераХранилище);
	
КонецПроцедуры 

#КонецОбласти