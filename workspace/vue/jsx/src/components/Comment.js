export default {
    functional: true,
    render(h, { props }) {
        const { content } = props
        return <div class="comment">
            {content}
        </div>
    }
}