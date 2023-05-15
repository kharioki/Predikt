export function Jumbotron () {
  return (
    <section className="bg-white">
      <div className="py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16">
        <h1 className="mb-4 text-4xl font-extrabold tracking-tight leading-none md:text-5xl lg:text-6xl">A climate positive prediction marketplace.</h1>
        <p className="mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 lg:px-48">Predikt is a platform that allows you to bet crypto assets on the outcome of real world events. For every bet, you also get to redeem carbon tokens, as we gradually work towards reducing our carbon footprint.</p>
        <div className="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0 sm:space-x-4">
          <a 
            href="/marketplace" 
            className="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-charcoal rounded-lg bg-lime hover:bg-gypsum focus:ring-4 focus:ring-green-300"
          >
            Go to Marketplace
            <svg aria-hidden="true" className="ml-2 -mr-1 w-5 h-5 animate-pulse" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
          </a> 
        </div>
      </div>
    </section>
  )
}