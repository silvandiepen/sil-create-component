import { defineComponent } from "vue";
import { Style } from "@sil/tools";

export default defineComponent({
  setup() {
    const style = new Style("FILE_NAME");
    return {
      style,
    };
  },
});
