
#Область ПрограммныйИнтерфейс

// Данные алгоритма сервиса.
// 
// Параметры:
//  ИдентификаторАлгоритма Идентификатор алгоритма
// 
// Возвращаемое значение:
//  см. НовыйДанныеАлгоритма 
// Возвращаемое значение:
// Неопределено - Получать данные не удалось
Функция ДанныеАлгоритмаСервиса(ИдентификаторАлгоритма) Экспорт
	Попытка
		Данные = УИ_КоннекторHTTP.GetJson("https://paste1c.ru/json/" + ИдентификаторАлгоритма);
	Исключение
		Возврат Неопределено;
	КонецПопытки;

	ДанныеВозврата = НовыйДанныеАлгоритма();
	ДанныеВозврата.Текст = ?(Данные["code"] = Неопределено, "", Данные["code"]);
	ДанныеВозврата.РежимЗапроса = ЗначениеЗаполнено(Данные["query_mode"]);

	Возврат ДанныеВозврата;
КонецФункции

// Результат загрузки алгоритма в сервис.
// 
// Параметры:
//  ТекстАлгоритма -Строка -Текст алгоритма
//  РежимЗапроса - Булево-Режим запроса
// 
// Возвращаемое значение:
// см.НовыйРезультатЗагрукиАлгоритма
// Возвращаемое значение:
// Неопределено - запрос вышел с ошибкой
Функция РезультатЗагрузкиАлгоритмаВСервис(ТекстАлгоритма, РежимЗапроса) Экспорт
	ДанныеОтправки = Новый Структура("Shared", Новый Структура);
	ДанныеОтправки.Shared.Вставить("code", ТекстАлгоритма);
	ДанныеОтправки.Shared.Вставить("query_mode", ?(РежимЗапроса, 1, 0));
	
	Попытка
		Результат = УИ_КоннекторHTTP.PostJson("https://paste1c.ru/paste", ДанныеОтправки);
	Исключение
		Возврат Неопределено;
	КонецПопытки;

	Успешно =  Результат["success"];
	Если Успешно = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	ДанныеВозврата = НовыйРезультатЗагрукиАлгоритма();
	ДанныеВозврата.Успешно = Успешно;
	Если ДанныеВозврата.Успешно Тогда
		ДанныеВозврата.Идентификатор = Результат["id"];
		ДанныеВозврата.Ссылка = Результат["full_url"];
		ДанныеВозврата.СсылкаJSON = Результат["json_url"];
	Иначе
		ДанныеВозврата.Ошибки = СтрСоединить(Результат["error"], ";");
	КонецЕсли;

	Возврат ДанныеВозврата;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Новый данные алгоритма.
// 
// Возвращаемое значение:
//  Структура -  Новый данные алгоритма:
// * Текст - Строка - 
// * РежимЗапроса - Булево - 
Функция НовыйДанныеАлгоритма() Экспорт
	Данные = Новый Структура;
	Данные.Вставить("Текст", "");
	Данные.Вставить("РежимЗапроса", Ложь);
	
	Возврат Данные;
КонецФункции

// Новый результат загруки алгоритма.
// 
// Возвращаемое значение:
//  Структура -  Новый результат загруки алгоритма:
// * Успешно - Булево - 
// * Идентификатор - Строка - 
// * Ссылка - Строка - 
// * СсылкаJSON - Строка - 
Функция НовыйРезультатЗагрукиАлгоритма() 
	Структура = Новый Структура;
	Структура.Вставить("Успешно", Ложь);
	Структура.Вставить("Идентификатор", "");
	Структура.Вставить("Ссылка", "");
	Структура.Вставить("СсылкаJSON", "");
	Структура.Вставить("Ошибки", "");
	
	Возврат Структура;
КонецФункции

#КонецОбласти
