<template>
    <div class="ui form choose">
        <div class="inline fields">
            <div class="ui radio checkbox">
                <input type="radio" name="answer" checked="" tabindex="0"
                    class="hidden" />
                <label>中国</label>
            </div>
            <div class="ui radio checkbox">
                <input type="radio" name="answer" checked="" tabindex="0"
                    class="hidden" />
                <label>美国</label>
            </div>
            <div class="ui radio checkbox">
                <input type="radio" name="answer" checked="" tabindex="0"
                    class="hidden" />
                <label>日本</label>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    mounted() {
        $("ui radio checkbox").checkbox();
    }
}
</script>

<style>
</style>