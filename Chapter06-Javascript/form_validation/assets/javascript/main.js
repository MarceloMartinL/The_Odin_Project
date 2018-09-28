const email = document.getElementById('email');
const emailConfirmation = document.getElementById('email-confirmation');
const password = document.getElementById('password');
const passwordConfirmation = document.getElementById('password-confirmation');
const country = document.getElementById('country');
const zipCode = document.getElementById('zip-code');
const submit = document.getElementsByTagName('button')[0];
const countryRegex = /[A-Z][A-Za-z' -]+/;
const zipRegex = /[0-9]{3}-[0-9]{3}-[0-9]{3}/

email.addEventListener('input', () => {
	let errorSpan = email.nextElementSibling;
	if (email.validity.valueMissing) {
		errorSpan.innerHTML = "Debes ingresar un email.";
		email.setCustomValidity("Porfavor ingresar un email.");
	} else if (email.validity.typeMismatch) {
		errorSpan.innerHTML = "Porfavor ingresa un email valido.";
	} else {
		errorSpan.innerHTML = "";
		email.setCustomValidity("");
	}
});

emailConfirmation.addEventListener('input', () => {
	let errorSpan = emailConfirmation.nextElementSibling;
	if (!emailConfirmation.validity.valid) {
		errorSpan.innerHTML = "Porfavor ingresa un email valido.";
	} else if (email.value !== emailConfirmation.value) {
		errorSpan.innerHTML = "El email no coincide.";
	} else {
		errorSpan.innerHTML = "";
	}
});

password.addEventListener('input', () => {
	let errorSpan = password.nextElementSibling;
	if (password.validity.valueMissing) {
		errorSpan.innerHTML = "Debes ingresar una contraseña.";
		password.setCustomValidity("Porfavor ingresa una contraseña.");
	} else if (password.validity.tooShort) {
		errorSpan.innerHTML = "La contraseña debe tener minimo 6 caracteres."
	} else {
		errorSpan.innerHTML = "";
		password.setCustomValidity("");
	}
});

passwordConfirmation.addEventListener('input', () => {
	let errorSpan = passwordConfirmation.nextElementSibling;
	if (passwordConfirmation.validity.valueMissing) {
		errorSpan.innerHTML = "Debes ingresar una contraseña.";
		passwordConfirmation.setCustomValidity("Porfavor ingresa la confirmacion de tu contraseña.");
	} else if (passwordConfirmation.validity.tooShort) {
		errorSpan.innerHTML = "La contraseña debe tener minimo 6 caracteres.";
	} else if (password.value !== passwordConfirmation.value) {
		errorSpan.innerHTML = "La contraseña no coincide.";
	} else {
		errorSpan.innerHTML = "";
		passwordConfirmation.setCustomValidity("");
	}
});

country.addEventListener('input', () => {
	let errorSpan = country.nextElementSibling;
	if (country.validity.valueMissing) {
		errorSpan.innerHTML = "Debes ingresar un pais.";
	} else if (!countryRegex.test(country.value)) {
		errorSpan.innerHTML = "Debes ingresar un pais valido.";
	} else {
		errorSpan.innerHTML = "";
	}
});

zipCode.addEventListener('input', () => {
	let errorSpan = zipCode.nextElementSibling;
	if (zipCode.validity.valueMissing) {
		errorSpan.innerHTML = "Debes ingresar un codigo zip.";
	} else if (!zipRegex.test(zipCode.value)) {
		errorSpan.innerHTML = "Formato de codigo invalido. e.g. (xxx-xxx-xxx).";
	} else {
		errorSpan.innerHTML = "";
	}
});