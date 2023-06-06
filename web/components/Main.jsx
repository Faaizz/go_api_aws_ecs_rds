import Head from 'next/head'

function Main(props) {
  return (
    <>
      <Head>
        <title>Hello World</title>
        <link rel="icon" href="/favicon.png" />
      </Head>

      <div>{props.books}</div>

    </>
  )
}

export default Main
