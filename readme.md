## lab1

Разработать базу знаний, содержащую сведения о генеалогическом дереве. Разработать правила, отражающие следующую семантику созданной базы данных:

+ Всякий, кто имеет ребенка, – счастлив.
+ Всякий X, имеющий ребенка, у которого есть сестра или брат, имеет двух детей.
+ Определите отношение ВНУК (Х,Y), используя отношение РОДИТЕЛЬ.
+ Определите отношение ТЕТЯ (Х,Y) через отношения РОДИТЕЛЬ и СЕСТРА.

![1741704764893](image/readme/1741704764893.png)

## lab2

Разработайте базу данных, содержащую сведения об игрушках, предлагаемых в магазине: название игрушки (кукла, кубики, мяч, и т.д.), ее стоимость и возрастные границы детей, для которых игрушка предназначена. Получить следующие сведения (примерный перечень, придумать еще столько же):

1. название игрушек, цена которых не превышает 400 руб. и которые подходят детям 5 лет;
2. название игрушек, которые подходят как детям 4 лет, так и детям 10 лет;
3. цены всех кубиков;
4. можно ли дедушке подобрать внуку на день рождения игрушку, любую, кроме мяча, подходящую ребенку 3 лет, и дополнительно мяч так, чтобы суммарная стоимость покупки не превосходила 500 руб.;
5. название наиболее дорогих игрушек (цена которых отличается от самой дорогой игрушки не более чем на 100 руб

## lab3

1. написать программу (используя внутреннюю базу данных), позволяющую спрашивать у пользователя, каким языком он владеет,
   и записывать ответы в базу данных.
2. в базу данных включите факты: ЯЗЫК(...), ВЛАДЕЕТ ( _ , _ );
3. измените программу, включив в нее предикаты чтения базы данных из файла и записи в файл по окончании сеанса работы.
4. Измените свое индивидуальное задание из лабораторной работы № 2 таким образом, чтобы все основные факты вашей программы хранились во
   внутренней базе данных (считывались из файла, обрабатывались программой и снова записывались в файл). При этом введите диалог с пользователем для
   добавления или удаления фактов в базу данных (за основу организации диалога возьмите предыдущее задание 1).

## lab4

Напишите программу, определяющую основные отношения на множествах

1. ОБЪЕДИНЕНИЕ;
2. ПЕРЕСЕЧЕНИЕ;
3. ВЫЧИТАНИЕ;
4. ДЕКАРТОВО ПРОИЗВЕДЕНИЕ.

## lab5

Напишите программу, которая преобразует логическую формулу F1 в логическую формулу F2, используя следующие аксиомы:

true V F=true и false & F=false, где F – логическая формула.

## lab6

Дан текстовый файл, разделенный на строки. Выравнивание строки заключается в том, что между ее отдельными словами дополнительно вносятся пробелы так, чтобы длина строки стала равной заданной длине (требуемая длина не меньше исходной), а последнее слово строки сдвинулось к ее правому краю. Напишите программу выравнивания строк данного текста.
