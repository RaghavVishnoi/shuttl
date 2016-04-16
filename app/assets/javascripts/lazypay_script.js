//Change of button text 'lazypay now' to 'confirm' in scenario one
function jssButton() {
  if (window.innerWidth < 768) {
    document.getElementById("lazyPayNow").value = "Confirm";
  } else {
    document.getElementById("lazyPayNow").value = "LazyPay Now";
  }
}
document.ready = jssButton;
window.onresize = jssButton;


//Mobile screen slider left and right function
var slidetoggle = document.getElementById("benefits-pannel"),
  benefitSlideLeft = document.getElementById("slideLeftButton");
benefitSlideRight = document.getElementById("slideRightButton");

benefitSlideLeft.addEventListener("click", function () {
  slidetoggle.classList.add("slide");
  document.getElementById("slideLeftButton").classList.add("active");

  //onclick remove the mobile animation;
  removeAnimate();
});
benefitSlideRight.addEventListener("click", function () {
  slidetoggle.classList.remove("slide");
  benefitSlideLeft.classList.remove("active");
  //console.log('click');
});


//remove mobile vibration animation
function removeAnimate() {
  setTimeout(function () {
    document.getElementById("mobile-screen").classList.remove('vibe-animation');
  }, 2500);
}
if (window.innerWidth >= 768) {
  removeAnimate();
}


//Read only the number keys on keyboard
function onlyNumbers(event) {
  if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)) // 0-9 or numpad 0-9
  {
    // check textbox value now and tab over if necessary
  }
  else if (event.keyCode !== 9 && event.keyCode !== 46 && event.keyCode !== 37 && event.keyCode !== 39 && event.keyCode !== 8) // not esc, del, left or right
  {
    event.preventDefault();
  }
  // else the key should be handled normally
  //console.log("click");
}


function otpHideHead() {
  document.querySelector(".error-png").style.display = "none";
  document.querySelector(".error-head").style.display = "none";
}
function otpShowHead() {
  document.querySelector(".error-png").style.display = "block";
  document.querySelector(".error-head").style.display = "block";
}

//resend state
var btn_resend = document.querySelector(".resend");

btn_resend.addEventListener('click', function () {
  //open error popup
  errorPopup();
  otpHideHead();
  otp_number.parentElement.classList.remove("error-border");
  //show error message
  document.getElementById('error-otp').innerHTML = "We've sent you a new OTP";
  document.getElementById('otp-number').value = "";

  //animate phone
  document.getElementById("mobile-screen").classList.add("vibe-animation");
  //phone remove animation
  removeAnimate();
});


// validation


//error msgs
var fadeIn = document.querySelector('.js-fade'),
  removeError = document.getElementById("otp-screen"),
  string = document.getElementById('error-otp');


//submit otp by mouse click
document.getElementById("lazyPayNow").addEventListener("click", function () {
  otpValidationTrigger();
});

// document.getElementById("lazyPayNow").addEventListener("click", function(){
// 	window.opener.runCallbackFunction();
// });

//submit otp by hit enter button from the keyboard
document.getElementById("otp-number").addEventListener("keydown", function (event) {
  if (event.keyCode == 13) {
    otpValidationTrigger();
  }
  ;
});
document.getElementById("email-address").addEventListener("keydown", function (event) {
  if (event.keyCode == 13) {
    otpValidationTrigger();
  }
  ;
});

//disabled the tab button once you reach the submit otp button to prevent the slider movement
function disbleTab(event) {
  if (event.keyCode == 13) {
    otpValidationTrigger();
  }
  ;
  if (event.keyCode == 8) {
  } else {
    event.preventDefault();
  }
}


function otpValidationTrigger() {
  if (validateOTPForm()) {

    document.getElementById("otp-screen").classList.add("active");
    document.getElementById("card-screen").classList.add("active");
    document.getElementById("slider-child-1").classList.remove("active");
    document.getElementById("slider-child-2").classList.add("active");

    otp_number.parentElement.classList.remove("error-border");

  } else {
    errorPopup();
    otpShowHead();
    hideOTPFormErrorMessages();
  }

}


function hideOTPFormErrorMessages() {
  var txtFieldBoxes = document.querySelectorAll(".input-otp");
  for (var i = 0; i < txtFieldBoxes.length; i++) {
    txtFieldBoxes[i].classList.remove("error");
  }
}

var otp_number = document.getElementById('otp-number'),
  email_address = document.getElementById('email-address'),
  errorOtpMessage = document.getElementById('error-otp');
errorBorder = document.querySelector(".input-otp");

// Below Function Executes On OTP Form Submit
function validateOTPForm() {
  //return true;

  // alert(otp_number);
// Regular Expression For Email & OTP
  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  //only numbers and 4 digits
  var otpReg = /^[0-9]{4}$/;
// Conditions

  if (otp_number.value !== '' && email_address.value !== '') {

    if (email_address.value.match(emailReg)) {
      if (otp_number.value.match(otpReg)) {
        return true;
      } else {
        otp_number.parentElement.classList.add("error-border");
        errorOtpMessage.innerHTML = "You have entered the invalid OTP!";
        return false;
      }
    } else {
      email_address.parentElement.classList.add("error-border");
      errorOtpMessage.innerHTML = "Please enter a valid email address!";
      return false;
    }
  } else {
    var txtFieldBoxes = removeError.querySelectorAll(".input-otp");

    for (var i = 0; i < txtFieldBoxes.length; i++) {
      if (otp_number.value === '' && email_address.value === '') {
        otp_number.parentElement.classList.add("error-border");
        email_address.parentElement.classList.add("error-border");
        errorOtpMessage.innerHTML = "Please enter your OTP and email address";
        return false;
      } else {
        if (otp_number.value === '') {
          otp_number.parentElement.classList.add("error-border");
          errorOtpMessage.innerHTML = "Please enter your OTP!";
          return false;
        } else if (email_address.value === '') {
          email_address.parentElement.classList.add("error-border");
          errorOtpMessage.innerHTML = "Please enter your email address!";
          return false;
        } else {
          return false;
        }
      }
      txtFieldBoxes[i].classList.add("error-border");
      errorOtpMessage.innerHTML = "Please enter the OTP!";
    }

    if (otp_number.value !== '') {
      otp_number.parentElement.classList.remove("error-border");
    }
    else if (email_address.value !== '') {
      email_address.parentElement.classList.remove("error-border");
    }

    return false;
  }
}


var ccnum = document.getElementById('card-number'),
  type = document.getElementById('ccnum-type'),
  expiry = document.getElementById('card-expire'),
  cvc = document.getElementById('card-cvv'),
  submit = document.getElementById('submit'),
  result = document.getElementById('result');

payform.cardNumberInput(ccnum);
payform.expiryInput(expiry);
payform.cvcInput(cvc);

ccnum.addEventListener('input', updateType);

submit.addEventListener('click', function (e) {
  e.preventDefault();
  cardValidationTrigger();
});

cvc.addEventListener("keydown", function (event) {
  if (event.keyCode == 13) {
    cardValidationTrigger();
  }
});

function cardValidationTrigger() {
  //document.getElementById('card-error-msg').style.display="none";
  var valid = [],
    expiryObj = payform.parseCardExpiry(expiry.value),
    isValidEntry = true;

  valid.push(fieldStatus(ccnum, payform.validateCardNumber(ccnum.value)));
  valid.push(fieldStatus(expiry, payform.validateCardExpiry(expiryObj)));
  valid.push(fieldStatus(cvc, payform.validateCardCVC(cvc.value, type.innerHTML)));

  for (var i = 0; i < valid.length; i++) {
    if (valid[i] === false) {
      isValidEntry = false;
    }
  }

  console.log(isValidEntry);

  if(isValidEntry) {
    window.runCallbackFunction && window.runCallbackFunction(isValidEntry);
  }
}

function updateType(e) {
  var cardType = payform.parseCardType(e.target.value);

  type.innerHTML = '' || '';
  if (cardType == null) {
    type.style.background = "url('/assets/cardblank.png') no-repeat";
  }
  else if (cardType === "visa") {
    //42 start for checking
    type.style.background = "url('/assets/visa.png') no-repeat";
  }
  else if (cardType === "amex") {
    //37 start for checking
    type.style.background = "url('/assets/amex.png') no-repeat";
  }
  else if (cardType === "discover") {
    type.style.background = "url('/assets/discover.png') no-repeat";
  }
  else if (cardType === "mastercard") {
    //53 start for checking
    type.style.background = "url('/assets/mastercard.png') no-repeat";
  }
  else if (cardType === "maestro") {
    //67 start for checking
    type.style.background = "url('/assets/maestro.png') no-repeat";
  }
  else if (cardType === "visaelectron") {
    type.style.background = "url('/assets/visaele.png') no-repeat";
  }
  else if (cardType === "jcb") {
    //35 start for checking
    type.style.background = "url('/assets/jcb.png') no-repeat";
  }
  else if (cardType === "unionpay") {
    //62 start for checking
    type.style.background = "url('/assets/unionpay.png') no-repeat";
  }
  else if (cardType === "discover") {
    //60 start for checking
    type.style.background = "url('/assets/discover.png') no-repeat";
  }
  else if (cardType === "dinersclub") {
    //36 start for checking
    type.style.background = "url('/assets/diner.png') no-repeat";
  }

}


function fieldStatus(input, valid) {
  if (valid) {
    removeClass(input.parentNode, 'error');

  } else {
    addClass(input.parentNode, 'error');

    errorPopup();
    otpShowHead();
    document.getElementById('error-otp').innerHTML = "Please enter the correct details!";
  }
  return valid;
}

function addClass(ele, _class) {
  if (ele.className.indexOf(_class) === -1) {
    ele.className += ' ' + _class;
  }
}

function removeClass(ele, _class) {
  if (ele.className.indexOf(_class) !== -1) {
    ele.className = ele.className.replace(_class, '');
  }
}


//fadeIn and fadeOut animation popup
var fadeInBg = document.querySelector(".demo_bg");
var fadeInBox = document.querySelector(".error-popup");

function errorPopup() {
  fadeInBg.style.display = "block";
  fadeInBox.style.display = "block";

  setTimeout(function () {
    fadeInBg.style.opacity = 1;
    fadeInBox.style.opacity = 1;
  }, 50);
}

document.getElementById("fadeOut").addEventListener("click", function () {
  fadeInBg.style.opacity = 0;
  fadeInBox.style.opacity = 0;

  setTimeout(function () {
    fadeInBg.style.display = "none";
    fadeInBox.style.display = "none";
  }, 50);

});


/////////// window resize

window.onresize = function () {
  if (window.innerWidth > 768) {
    slidetoggle.style.left = 0;
  }

}
