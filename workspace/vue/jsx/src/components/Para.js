export default {
    props: ['message'],
    render(h) { 
        return <p>
            {this.message}
        </p>
    }
}