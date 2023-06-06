import axios from 'axios'
import Main from '../components/Main'

export default function Home(props) {
	return <Main books={props.books} />
}

export async function getServerSideProps(context) {
	try {
		const res = await axios({
			method: 'get',
			url: process.env.BOOK_URL,
		})
		return {
			props: {
				books: JSON.stringify(res.data),
			},
		}
	} catch (err) {
		console.log(err)
		return {
			props: {
				books: [],
			},
		}
	}
}
