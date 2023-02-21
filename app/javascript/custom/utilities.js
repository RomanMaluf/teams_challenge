
// Similar to Jquery .on function
function on (type, el, listener, all = false) {
  if (all) {
    document.querySelectorAll(el).forEach(e => e.addEventListener(type, listener))
  } else {
    document.querySelector(el).addEventListener(type, listener)
  }
}

// const onscroll = (el, listener) => {
//   el.addEventListener('scroll', listener)
// }


export { on }
