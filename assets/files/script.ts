import { defineComponent } from "vue";
import { createBemm } from "bemm";

export default defineComponent({
  setup() {
    const bemm = createBemm("FILE_NAME");
    return {
      bemm,
    };
  },
});
