$(document).ready(function () {

  let profileForm = $("#profile_form");
  let searchForm = $("#search_form");

  profileForm.validate({
    rules: {
      name: {
        required: true,
      },

      url: {
        required: true,
      }
    },

    messages: {
      name: {
        required: "Insira um nome.",
      },

      url: {
        required: "Insira um endereço.",
      }
    },

    submitHandler: function(form) {
      doStartLoader()
      form.submit();
    }
  })

  searchForm.validate({
    rules: {
      search: {
        required: true,
      }
    },

    messages: {
      search: {
        required: "Insira um termo para busca.",
      }
    },

    submitHandler: function(form) {
      doStartLoader()
      form.submit();
    }
  })

})

function doStartLoader() {
  $(".page").append("<div class='loaders loaders_primary all'><div class='loader_icon medium'></div></div>")
}
