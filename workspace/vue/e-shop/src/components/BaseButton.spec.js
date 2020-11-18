import BaseButton from "./BaseButton.vue"
import {shallow} from 'vue-test-utils'
import { exportAllDeclaration } from "@babel/types";

describe('BaseButton', () => {
    test('click event', () => {
        const wrapper = shallow(BaseButton)
        wrapper.trigger('click')
        except(wrapper.emitted().click).toBeTruthy()
    })
})
