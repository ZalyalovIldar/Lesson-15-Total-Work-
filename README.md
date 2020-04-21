# Lesson-15-Total-Work

## Home work: 

Приложение, которое использует Realm для хранения данных, UIViewPropertyAnimator и покрыто тестами. 

1. Экран со списком данных из сети. Содержит изображение и пару лейблов с данными. 
2. Подробный экран с детальными данными. Содержит весь набор данных, может скроллиться + имеет кнопку "крестик" для закрытия.
3. По долгому нажатию на ячейке анимационно открывать экран в виде карточки, как в телеге чаты, но без экшенов типа шеринга и т.д. Условно по центру или чуть выше центра карточка с закругленными краями, а экран за карточкой заблюрен. 
  * Карточка не скроллится, пока не раскрыли полностью. 
  * Карточка должна раскрываться анимационно на весь экран при нажатии на нее. 
  * Анимацию карточки можно контролировать пальцем, свайпая вверх медленно раскрывать ее. После отпускания пальца, должно   раскрыться полностью. 
  * Карточка должна сворачиваться так же контролируемо, если происходит свайп вниз на карточке + проскроллено к самому верху. 
  * По нажатию на крестик в карточке - просто анимационное сворачивание. 
4. По обычному нажатию на ячейку - открывать анимационно карточку.
5. Данные таблицы можно удалить/изменить. Обновление реализуйте как удобно.
6. Подробный экран с данными - это обычная UIView, которая начинает расти с позиции ячейки, на которую нажали/долго держали.
7. Покройте весь проект тестами, чем выше покрытие тестами - тем лучше. Постарайтесь делать качественные тесты. Все ваши классы должны быть покрыты тестами.

**API**: можно использовать любое API, главное это иметь картинку, несколько лейблов с данными и какой нибудь длинный текст.   
**Хранение данных**: Все данные кешируются в Realm. Удаления/изменение так же кешируется в Realm. От 10 до 20 объектов.     
**Доп. баллы**: 
* Добавить [HapticFeedback](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/) при нажатии на ячейку/при долгом нажатии на ячейку. 
* Сделать анимации открытия/закрытия прерываемыми. 
