# Week 04. "Сломано" (Slurm Навыкум "Build Containers!")

По мотивам "Потрачено"

## Задача

Разработчики одного из приложений нашей компании решили "реанимировать" один из своих проектов, который раньше собирали с помощью Docker на Java 11

Говорят, что раньше (года три назад), работало всё отлично, а теперь они переехали на Java 17 и всё сломалось 😢

Попробовали откатиться на Java 11 &ndash; тоже не работает 😭

Говорят, что ничего не меняли*

Примечание*: ну тут, конечно, верить точно нельзя

<details>
<summary>Спойлеры</summary>

Спойлеры смотреть не хорошо 😈!

Возможно, что Java тут совсем ни при чём

</details>

### Как работало "до этого"

1. Собирали через `docker build -t client .`
2. При запуске указывали `URL`, который нужно протестировать, например: `docker run client https://slurm.io`
3. В ответ получали (кроме всех логов): `00:00:00.000 [main] INFO org.example.Main -- check status true`

### Что нужно сделать

Сделать так, чтобы "заработало"

Под "заработало" в данном случае понимается, что тесты должны проходить и образ собирался

При этом:
1. Код приложения редактировать **нельзя**
2. Базовые образы редактировать **нельзя**
3. Команду сборки `mvn verify` редактировать **нельзя**
4. Всё остальное в `Dockerfile` редактировать можно
5. Авто-тесты редактировать можно путём добавления информации (удалять оттуда тесты или менять значения адресов &ndash; **нельзя**)

<details>
<summary>Спойлеры: про публичные CI/CD</summary>

Будьте готовы к тому, что не всегда некоторые сервисы будут доступны из публичных (и уж тем более &ndash; зарубежных) CI/CD, поэтому при необходимости, можете, например, пропускать тесты при определённой конфигурации (желательно не совсем все, а только те, которые гарантированно не проходят в данной конфигурации)

Ещё лучше будет, если вы в `GITHUB.md` предложите собственное решение (что делать с данной проблемой), которое можно обсудить на разборе*

Примечание*: вариант "сделать так, чтобы всё работало" &ndash; самый правильный, но давайте попробуем поискать именно решение в существующих ограничениях

</details>

### Требования

1. Всё должно быть оформлено в виде публичного репозитория на GitHub
2. Вся сборка образов должна проходить через GitHub Actions
3. Образ должен выкладываться в GitHub Container Registry (GHCR)