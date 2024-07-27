import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import mixins from './mixins' //공통??
import store from './store'
import VueSweetalert2 from 'vue-sweetalert2' 
import 'sweetalert2/dist/sweetalert2.min.css' 

const app = createApp(App)
app.use(router)
app.mixin(mixins)
app.use(store)
app.use(VueSweetalert2) 
app.mount('#app')

window.Kakao.init("6293cc9ef2643397cea23c1a4990db50")
