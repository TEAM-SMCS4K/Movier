<%--
  Created by IntelliJ IDEA.
  User: nache
  Date: 24. 5. 23.
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Star Rating</title>
    <link rel="stylesheet" href="/css/starRating.css">
</head>
<body>
<div style="display: flex; align-items: center;">
    <span id="rating-number" style="margin-right: 8px;">0</span>
    <div class="rating">
        <label class="rating__label rating__label--half" for="starhalf">
            <input type="radio" id="starhalf" class="rating__input" name="rating" value="0.5">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--full" for="star1">
            <input type="radio" id="star1" class="rating__input" name="rating" value="1">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--half" for="star1half">
            <input type="radio" id="star1half" class="rating__input" name="rating" value="1.5">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--full" for="star2">
            <input type="radio" id="star2" class="rating__input" name="rating" value="2">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--half" for="star2half">
            <input type="radio" id="star2half" class="rating__input" name="rating" value="2.5">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--full" for="star3">
            <input type="radio" id="star3" class="rating__input" name="rating" value="3">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--half" for="star3half">
            <input type="radio" id="star3half" class="rating__input" name="rating" value="3.5">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--full" for="star4">
            <input type="radio" id="star4" class="rating__input" name="rating" value="4">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--half" for="star4half">
            <input type="radio" id="star4half" class="rating__input" name="rating" value="4.5">
            <span class="star-icon"></span>
        </label>
        <label class="rating__label rating__label--full" for="star5">
            <input type="radio" id="star5" class="rating__input" name="rating" value="5">
            <span class="star-icon"></span>
        </label>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const rateWrap = document.querySelectorAll('.rating'),
            label = document.querySelectorAll('.rating .rating__label'),
            input = document.querySelectorAll('.rating .rating__input'),
            labelLength = label.length,
            opacityHover = '0.5',
            ratingNumber = document.getElementById('rating-number');

        let stars = document.querySelectorAll('.rating .star-icon');

        checkedRate();

        rateWrap.forEach(wrap => {
            wrap.addEventListener('mouseenter', () => {
                stars = wrap.querySelectorAll('.star-icon');

                stars.forEach((starIcon, idx) => {
                    starIcon.addEventListener('mouseenter', () => {
                        initStars();
                        filledRate(idx, labelLength);

                        for (let i = 0; i < stars.length; i++) {
                            if (stars[i].classList.contains('filled')) {
                                stars[i].style.opacity = opacityHover;
                            }
                        }
                    });

                    starIcon.addEventListener('mouseleave', () => {
                        starIcon.style.opacity = '1';
                        checkedRate();
                    });

                    wrap.addEventListener('mouseleave', () => {
                        starIcon.style.opacity = '1';
                    });
                });
            });
        });

        input.forEach(radio => {
            radio.addEventListener('change', (event) => {
                ratingNumber.textContent = event.target.value;
            });
        });

        function filledRate(index, length) {
            if (index <= length) {
                for (let i = 0; i <= index; i++) {
                    stars[i].classList.add('filled');
                }
            }
        }

        function checkedRate() {
            let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');

            initStars();
            checkedRadio.forEach(radio => {
                let previousSiblings = prevAll(radio);

                for (let i = 0; i < previousSiblings.length; i++) {
                    previousSiblings[i].querySelector('.star-icon').classList.add('filled');
                }

                radio.nextElementSibling.classList.add('filled');
                ratingNumber.textContent = radio.value;

                function prevAll(radio) {
                    let radioSiblings = [],
                        prevSibling = radio.parentElement.previousElementSibling;

                    while (prevSibling) {
                        radioSiblings.push(prevSibling);
                        prevSibling = prevSibling.previousElementSibling;
                    }
                    return radioSiblings;
                }
            });
        }

        function initStars() {
            for (let i = 0; i < stars.length; i++) {
                stars[i].classList.remove('filled');
            }
        }
    });
</script>
</body>
</html>