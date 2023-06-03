

#Область ПрограммныйИнтерфейс

Функция ПрефиксЭлементовРедактораКода() Экспорт
	Возврат "РедакторКода1С";
КонецФункции

Функция ИмяРеквизитаРедактораКода(ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_"+ИдентификаторРедактора;
КонецФункции

Функция ИмяРеквизитаРедактораКодаВидРедактора() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_ВидРедактора";
КонецФункции

Функция ИмяРеквизитаРедактораКодаАдресБиблиотеки() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_АдресБиблиотекиВоВременномХранилище";
КонецФункции

Функция ИмяРеквизитаРедактораКодаСписокРедакторовФормы() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_СписокРедакторовФормы";
КонецФункции

// Имя реквизита редактора кода первичная инициализация прошла.
// 
// Возвращаемое значение:
// Строка 
Функция ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла() Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_ПервичнаяИнициализацияПрошла";
КонецФункции

Функция ИмяРеквизитаРедактораКодаРедакторыФормы(ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода()+"_РедакторыФормы";
КонецФункции

Функция ИмяКнопкиКоманднойПанели(ИмяКоманды, ИдентификаторРедактора) Экспорт
	Возврат ПрефиксЭлементовРедактораКода() + "_" + ИмяКоманды + "_" + ИдентификаторРедактора;
КонецФункции

Функция ВариантыРедактораКода() Экспорт
	Варианты = Новый Структура;
	Варианты.Вставить("Текст", "Текст");
	Варианты.Вставить("Ace", "Ace");
	Варианты.Вставить("Monaco", "Monaco");

	Возврат Варианты;
КонецФункции

Функция ВариантРедактораПоУмолчанию() Экспорт
	Возврат ВариантыРедактораКода().Monaco;
КонецФункции

Функция РедакторКодаИспользуетПолеHTML(ВидРедактора) Экспорт
	Варианты=ВариантыРедактораКода();
	Возврат ВидРедактора = Варианты.Ace
		Или ВидРедактора = Варианты.Monaco;
КонецФункции

// Первичная инициализация редакторов прошла.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
// 
// Возвращаемое значение:
//  Булево
Функция ПервичнаяИнициализацияРедакторовПрошла(Форма) Экспорт
	Возврат Форма[ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла()];
КонецФункции 

// Установить признак первичная инициализация редакторов прошла.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//  ИнициализацияПрошла - Булево
Процедура УстановитьПризнакПервичнаяИнициализацияРедакторовПрошла(Форма, ИнициализацияПрошла) Экспорт
	Форма[ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла()] = ИнициализацияПрошла;
КонецПроцедуры

Функция ИдентификаторРедактораПоЭлементуФормы(Форма, Элемент) Экспорт
	РедакторыФормы = Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы()];

	Для Каждого КлючЗначение Из РедакторыФормы Цикл
		Если КлючЗначение.Значение.ПолеРедактора = Элемент.Имя Тогда
			Возврат КлючЗначение.Ключ;
		КонецЕсли;
	КонецЦикла;

	Возврат Неопределено;
КонецФункции

Функция СтруктураИмениКомандыФормы(ИмяКоманды) Экспорт
	МассивИмени = СтрРазделить(ИмяКоманды, "_");
	
	СтруктураИмени = Новый Структура;
	СтруктураИмени.Вставить("ИмяКоманды", МассивИмени[1]);
	СтруктураИмени.Вставить("ИдентификаторРедактора", МассивИмени[2]);
	
	Возврат СтруктураИмени;
КонецФункции

Функция ВыполнитьАлгоритм(__ТекстАлготима__, __Контекст__) Экспорт
	Успешно = Истина;
	ОписаниеОшибки = "";
	
	ВыполняемыйТекстАлгоритма = ДополненныйКонтекстомКодАлгоритма(__ТекстАлготима__, __Контекст__);

	НачалоВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Попытка
		Выполнить (ВыполняемыйТекстАлгоритма);
	Исключение
		Успешно = Ложь;
		ОписаниеОшибки = ОписаниеОшибки();
		Сообщить(ОписаниеОшибки);
	КонецПопытки;
	ОкончаниеВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();

	РезультатВыполнения = Новый Структура;
	РезультатВыполнения.Вставить("Успешно", Успешно);
	РезультатВыполнения.Вставить("ВремяВыполнения", ОкончаниеВыполнения - НачалоВыполнения);
	РезультатВыполнения.Вставить("ОписаниеОшибки", ОписаниеОшибки);

	Возврат РезультатВыполнения;
КонецФункции

Функция ВидРедактораКодаФормы(Форма) Экспорт
	Возврат Форма[УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаВидРедактора()];
КонецФункции

// Новый кэш текстов редактора.
// 
// Возвращаемое значение:
//  Структура - Новый кэш текстов редактора:
// * Текст - Строка -
// * ОригинальныйТекст - Строка -
Функция НовыйКэшТекстовРедактора() Экспорт
	Структура = Новый Структура;
	Структура.Вставить("Текст", "");
	Структура.Вставить("ОригинальныйТекст", "");
	
	Возврат Структура;
КонецФункции

Функция ИмяКомандыРежимВыполненияЧерезОбработку() Экспорт
	Возврат "РежимВыполненияЧерезОбработку";
КонецФункции

Функция ИмяКомандыКонструкторЗапроса() Экспорт
	Возврат "КонструкторЗапроса";
КонецФункции

// Редакторы формы.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения-Форма
// 
// Возвращаемое значение:
//  Структура из КлючИЗначение:
//  	* Ключ - Строка - Идентификатор редактора
//  	* Значение - см. НовыйДанныеРедактораФормы
Функция РедакторыФормы(Форма) Экспорт
	Возврат Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы()];
КонецФункции

// Новый данные редактора формы.
// 
// Возвращаемое значение:
//  Структура - Новый данные редактора формы:
// * СобытияРедактора - см. НовыйПараметрыСобытийРедактора, Неопределено -
// * Инициализирован - Булево -
// * Видимость - Булево -
// * ТолькоПросмотр - Булево -
// * КэшТекстаРедактора - см. УИ_РедакторКодаКлиентСервер.НовыйКэшТекстовРедактора, Неопределено -
// * Язык - Строка -
// * ПолеРедактора - Строка -
// * ИмяРеквизита - Строка -
// * ИспользоватьОбработкуДляВыполненияКода - Булево -
// * ПараметрыРедактора - см. ПараметрыРедактораКодаПоУмолчанию, Неопределено -
Функция НовыйДанныеРедактораФормы() Экспорт
	ДанныеРедактора = Новый Структура;
	ДанныеРедактора.Вставить("Идентификатор", "");
	ДанныеРедактора.Вставить("СобытияРедактора", Неопределено);
	ДанныеРедактора.Вставить("Инициализирован", Ложь);
	ДанныеРедактора.Вставить("Видимость", Истина);
	ДанныеРедактора.Вставить("ТолькоПросмотр", Ложь);
	ДанныеРедактора.Вставить("КэшТекстаРедактора", Неопределено);
	ДанныеРедактора.Вставить("Язык", "bsl");
	ДанныеРедактора.Вставить("ПолеРедактора", "");
	ДанныеРедактора.Вставить("ИмяРеквизита", "");
	ДанныеРедактора.Вставить("ИспользоватьОбработкуДляВыполненияКода", Истина);
	ДанныеРедактора.Вставить("ПараметрыРедактора", Неопределено);
	
	Возврат ДанныеРедактора;
КонецФункции

// Новый параметры событий редактора.
// 
// Возвращаемое значение:
//  Структура - Новый параметры событий редактора:
// * ПриИзменении - Строка -
Функция НовыйПараметрыСобытийРедактора() Экспорт
	СобытияРедактора = Новый Структура;
	СобытияРедактора.Вставить("ПриИзменении", "");
	
	Возврат СобытияРедактора;
КонецФункции
 
// Новый данные редактора для сборки обработки.
// 
// Возвращаемое значение:
//  Структура - Новый данные редактора для сборки обработки:
// * Идентификатор - Строка -
// * ИменаПредустановленныхПеременных - Массив из Строка -
// * ТекстРедактора - Строка -
// * ТекстРедактораДляОбработки - Строка -
// * ИсполнениеНаКлиенте - Булево -
Функция НовыйДанныеРедактораДляСборкиОбработки() Экспорт
	Данные = Новый Структура;
	Данные.Вставить("Идентификатор", "");
	Данные.Вставить("ИменаПредустановленныхПеременных", Новый Массив);
	Данные.Вставить("ТекстРедактора", "");
	Данные.Вставить("ТекстРедактораДляОбработки", "");
	Данные.Вставить("ИсполнениеНаКлиенте", Ложь);
	
	Возврат Данные;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ВариантыЯзыкаСинтаксисаРедактораMonaco() Экспорт
	ЯзыкиСинтаксиса = Новый Структура;
	ЯзыкиСинтаксиса.Вставить("Авто", "Авто");
	ЯзыкиСинтаксиса.Вставить("Русский", "Русский");
	ЯзыкиСинтаксиса.Вставить("Английский", "Английский");
	
	Возврат ЯзыкиСинтаксиса;
КонецФункции

Функция ВариантыТемыРедактораMonaco() Экспорт
	Варианты = Новый Структура;
	
	Варианты.Вставить("Светлая", "Светлая");
	Варианты.Вставить("Темная", "Темная");
	
	Возврат Варианты;
КонецФункции

Функция ТемаРедактораMonacoПоУмолчанию() Экспорт
	ТемыРедактора = ВариантыТемыРедактораMonaco();
	
	Возврат ТемыРедактора.Светлая;
КонецФункции
Функция ЯзыкСинтаксисаРедактораMonacoПоУмолчанию() Экспорт
	Варианты = ВариантыЯзыкаСинтаксисаРедактораMonaco();
	
	Возврат Варианты.Авто;
КонецФункции

Функция ПараметрыРедактораMonacoПоУмолчанию() Экспорт
	ПараметрыРедактора = Новый Структура;
	ПараметрыРедактора.Вставить("ВысотаСтрок", 0);
	ПараметрыРедактора.Вставить("Тема", ТемаРедактораMonacoПоУмолчанию());
	ПараметрыРедактора.Вставить("ЯзыкСинтаксиса", ЯзыкСинтаксисаРедактораMonacoПоУмолчанию());
	ПараметрыРедактора.Вставить("ИспользоватьКартуКода", Ложь);
	ПараметрыРедактора.Вставить("СкрытьНомераСтрок", Ложь);
	ПараметрыРедактора.Вставить("ОтображатьПробелыИТабуляции", Ложь);
	ПараметрыРедактора.Вставить("КаталогиИсходныхФайлов", Новый Массив);
	ПараметрыРедактора.Вставить("ФайлыШаблоновКода", Новый Массив);
	ПараметрыРедактора.Вставить("ИспользоватьСтандартныеШаблоныКода", Истина);
	
	Возврат ПараметрыРедактора;
КонецФункции

Функция ПараметрыРедактораКодаПоУмолчанию() Экспорт
	ПараметрыРедактора = Новый Структура;
	ПараметрыРедактора.Вставить("Вариант",  ВариантРедактораПоУмолчанию());
	ПараметрыРедактора.Вставить("РазмерШрифта", 0);
	ПараметрыРедактора.Вставить("Monaco", ПараметрыРедактораMonacoПоУмолчанию());
	
	Возврат ПараметрыРедактора;
КонецФункции

Функция НовыйОписаниеКаталогаИсходныхФайловКонфигурации() Экспорт
	Описание = Новый Структура;
	Описание.Вставить("Каталог", "");
	Описание.Вставить("Источник", "");
	
	Возврат Описание;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДополненныйКонтекстомКодАлгоритма(ТекстАлготима, Контекст)
	ПодготовленныйКод="";

	Для Каждого КлючЗначение Из Контекст Цикл
		ПодготовленныйКод = ПодготовленныйКод +"
		|"+КлючЗначение.Ключ+"=__Контекст__."+КлючЗначение.Ключ+";";
	КонецЦикла;

	ПодготовленныйКод=ПодготовленныйКод + Символы.ПС + ТекстАлготима;

	Возврат ПодготовленныйКод;
КонецФункции



#КонецОбласти