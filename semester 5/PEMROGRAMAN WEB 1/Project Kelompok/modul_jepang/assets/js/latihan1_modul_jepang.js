//declare all variables
var start = document.getElementById("start");
var quiz = document.getElementById("quiz");
var quizQuestion = document.getElementById("quizQuestion");
var quizImg = document.getElementById("quizImg");
var optionA = document.getElementById("choiceA");
var optionB = document.getElementById("choiceB");
var optionC = document.getElementById("choiceC");
var optionD = document.getElementById("choiceD");
var scoreBlock = document.getElementById("scoreBlock");
var scoreMessage = document.getElementById("scoreMessage");
var quizAgain = document.getElementById("quizAgain");
var choices = document.getElementById("choices");
var choiceResponse = document.getElementById("choiceResponse");
var score = 0;

//questions function so our getQuestion function later can get the right value from array

let questions = [{
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/hiragana/a.png",
    choiceA: "a",
    choiceB: "u",
    choiceC: "o",
    choiceD: "ka",
    correctAnswer: "A"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/hiragana/e.png",
    choiceA: "o",
    choiceB: "e",
    choiceC: "u",
    choiceD: "i",
    correctAnswer: "B"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/hiragana/gif/ko.gif",
    choiceA: "zo",
    choiceB: "go",
    choiceC: "ko",
    choiceD: "do",
    correctAnswer: "C"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/katakana/ta.png",
    choiceA: "fu",
    choiceB: "nu",
    choiceC: "wo",
    choiceD: "ta",
    correctAnswer: "D"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/katakana/gif/chi.gif",
    choiceA: "chi",
    choiceB: "tsu",
    choiceC: "wo",
    choiceD: "n",
    correctAnswer: "A"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/katakana/gif/tsu.gif",
    choiceA: "n",
    choiceB: "tsu",
    choiceC: "ku",
    choiceD: "na",
    correctAnswer: "B"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/katakana/gif/na.gif",
    choiceA: "ke",
    choiceB: "ta",
    choiceC: "fu",
    choiceD: "na",
    correctAnswer: "D"
}, {
    question: "Huruf apakah ini?",
    imgSrc: "assets/img/materi/huruf/katakana/gif/ku.gif",
    choiceA: "ke",
    choiceB: "ku",
    choiceC: "ki",
    choiceD: "ko",
    correctAnswer: "B"
}, {
    question: "Apa itu Lutut dalam bahasa Jepang?",
    imgSrc: "assets/img/latihan1/lutut.png",
    choiceA: "hiji",
    choiceB: "hiza",
    choiceC: "kubi",
    choiceD: "yubi",
    correctAnswer: "B"
}, {
    question: "Apa itu Tumit Kaki dalam bahasa Jepang?",
    imgSrc: "assets/img/latihan1/tumit.png",
    choiceA: "kakato",
    choiceB: "ashi",
    choiceC: "ashikubi",
    choiceD: "fukurahagi",
    correctAnswer: "A"
}, ];


var questionIndex = 0;


// getQuestion function

function getQuestion() {

    choiceResponse.style.display = "none";
    let q = questions[questionIndex];
    quizQuestion.innerHTML = "<p>Soal " +(questionIndex+1) + ": " + q.question + "</p>";
    quizImg.innerHTML = "<img src=" + q.imgSrc + ">";
    optionA.innerHTML = q.choiceA;
    optionB.innerHTML = q.choiceB;
    optionC.innerHTML = q.choiceC;
    optionD.innerHTML = q.choiceD;
    choices.style.display = "block";
}


// start quiz

function beginQuiz() {
    $("#latihan1").removeClass("mt-5");
    $('.hidden-start').hide();
    start.style.display ="none";
    getQuestion();
    quiz.style.display = "block";
}

// show score function

function showScore() {
    $("#latihan1").addClass("mt-5");
    quiz.style.display = "none";
    scoreBlock.style.display = "block";
    scoreBlock.innerHTML = "<h2> Skormu adalah " + score + " dari 10!</h2>";

    if (score < 4) {
        scoreMessage.innerHTML = "<p>Belajar lagi! Waktunya sedikit lebih serius.</p>";
    }
    else if (score < 8) {
        scoreMessage.innerHTML = "<p>Lumayan! Sedikit belajar lagi, pasti bisa.</p>"
    }
    else {
        scoreMessage.innerHTML = "<p>Pandai! Kamu telah belajar dengan sungguh-sungguh pertahanankan!</p>"
    }
    scoreMessage.style.display = "block";
    quizAgain.style.display = "inline-block";
}


//function to check if answer is correct

function check(answer) {
    if (questionIndex < questions.length - 1) {
        if (answer == questions[questionIndex].correctAnswer) {
            score++;
            questionIndex++;
            choices.style.display = "none";
            choiceResponse.innerHTML= "<p class='btn btn-success'>Benar!</p>"
            choiceResponse.style.display = "block";
            setTimeout(getQuestion,1500);
        }
        else {
            questionIndex++;
            choices.style.display = "none";
            choiceResponse.innerHTML= "<p class='btn btn-danger'>Salah!</p>"
            choiceResponse.style.display = "block";
            setTimeout(getQuestion,1500);
        }
    }
    else {
        if (answer == questions[questionIndex].correctAnswer) {
            score++;
            choices.style.display = "none";
            choiceResponse.innerHTML= "<p class='btn btn-success'>Benar!</p>"
            choiceResponse.style.display = "block";
            setTimeout(showScore,1500);
        }
        else {
            choices.style.display = "none";
            choiceResponse.innerHTML= "<p class='btn btn-danger'>Salah!</p>"
            choiceResponse.style.display = "block";
            setTimeout(showScore,1500);
        }
    }
}

function restartQuiz() {
    $('.hidden-start').show();
    start.style.display = "block";
    scoreBlock.style.display = "none";
    scoreMessage.style.display = "none";
    quizAgain.style.display = "none";
    score = 0;
    questionIndex = 0;
}
