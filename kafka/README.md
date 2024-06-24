**3-е Домашнее задание. Kafka.**

1. Поднят в docker-compose, из репозитория + sasl.
   docker-compose up -d
   ![Поднятый контейнер](/kafka/image/kafka_up.png)
2. Создан топик.
3. Написан python скрипт для заливки данных из таблицы клика (пегас) пары столбцов в топик кафка в формате json (100 записей).
   ![Отправленные данные](/kafka/image/producer1.png)
4. В программе Offset Explorer просмотрены данные в топике.
   ![Данные в приложении](/kafka/image/producer2.png)
5. Прочтены из топика python скриптом.
   ![Прочтенные данные](/kafka/image/consumer.png)
