<script>
Vue.component('now_playing', {
  data: function() {
    return { test: 'aho' };
  },
  methods: {
    fetch_info: function() {
      console.log('hello');
    },
  },
  template: '<h2>{{test}}</h2>',
});
</script>
