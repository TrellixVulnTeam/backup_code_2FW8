<template>
    <ul>
        <ol v-for="newitem in news" :key="newitem.id">
            <h3>{{newitem.title}}</h3>
            <p>{{newitem.content}}</p>
        </ol>
    </ul>
</template>
<script>
export default {
    async created() {
        const data = await this.$fetch("news");
        this.news = data;
    },
    data() {
        return {
            news: [],
        }
    }
}
</script>
<style scoped>
    ul, ol {
        padding: 0;
    }
</style>


