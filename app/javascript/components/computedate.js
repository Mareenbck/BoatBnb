const computeDate = () => {
  const endDate = document.querySelector("#end-date");
  const beginDate = document.querySelector("#begin-date");

  if (!endDate) return;

  endDate.addEventListener('change', computeNumberOfDays )
  beginDate.addEventListener('change', computeNumberOfDays )

}

const computeNumberOfDays = () => {
  const endDate = document.querySelector("#end-date");
  const beginDate = document.querySelector("#begin-date");
  const computeEndDate = (Date.parse(endDate.value));
  const computeBeginDate = (Date.parse(beginDate.value));
  const numberOfDays = ((computeEndDate - computeBeginDate) / (1000*60*60*24));
  const pricePerDay = document.querySelector(".price-per-days");
  const numberOfDaysDiv = document.querySelector(".nb-of-days");

  if (numberOfDays <= 0) return;

  numberOfDaysDiv.innerText = `Number of days : ${numberOfDays}`;
  pricePerDay.innerHTML = `<strong>Price : ${numberOfDays * parseInt(pricePerDay.dataset.price)} €</strong>`
}

export {computeDate};

