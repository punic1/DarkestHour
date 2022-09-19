function alpineInstance() {
    return {
        search: '',

        users: [],

        get filteredUsers() {
            return this.users.filter(
                i => i.name.toLowerCase().includes(this.search.toLowerCase()) || i.roid.includes(this.search)
            )
        },
    }
}