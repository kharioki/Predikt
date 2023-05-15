import { WalletIcon, MagnifyingGlassIcon } from '@heroicons/react/24/outline'

export default function BottomSection () {
  return (
    <div className="relative isolate overflow-hidden bg-lime py-16 sm:py-12 lg:py-16 rounded-sm">
      <div className="mx-auto max-w-7xl px-6 lg:px-8">
        <div className="mx-auto grid max-w-2xl grid-cols-1 gap-x-8 gap-y-16 lg:max-w-none lg:grid-cols-2">
          <div className="max-w-xl lg:max-w-lg">
            <h2 className="text-3xl font-light tracking-wide text-charcoal sm:text-4xl text-left">Why bet on Predikt?</h2>
            <p className="mt-4 text-lg leading-8 text-ash text-left">
              Predikt is a decentralized information markets platform which is harnessing the power of free markets to demystify real world events that matter. While doing so, we are also working towards reducing our carbon footprint.
            </p>
            <div className="mt-6 flex max-w-md gap-x-4">
              <a
                href="/marketplace"
                className="flex-none rounded-md bg-charcoal px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-ash focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-900"
              >
                Go to Marketplace
              </a>
            </div>
          </div>
          <dl className="grid grid-cols-1 gap-x-8 gap-y-10 sm:grid-cols-2 lg:pt-2">
            <div className="flex flex-col items-start">
              <div className="flex items-center space-x-2">
                <WalletIcon className="h-8 w-8 text-charcoal" aria-hidden="true" />
                <dt className="font-semibold text-charcoal text-lg">Guarantee instant payouts</dt>
              </div>
              <dd className="mt-2 leading-7 text-ash">
                As soon as the event outcome is known, the winning side will receive their payout right away in their Celo wallets.
              </dd>
            </div>
            <div className="flex flex-col items-center">
              <div className="flex items-center space-x-2">
                <MagnifyingGlassIcon className="h-8 w-8 text-charcoal" aria-hidden="true" />
                <p className="font-semibold text-charcoal text-lg">Transparent</p>
              </div>
              <dd className="mt-2 leading-7 text-ash">
                Everything is on-chain and verifiable. You can see the bets, the outcomes, and the payouts.
              </dd>
            </div>
          </dl>
        </div>
      </div>
      <div className="absolute left-1/2 top-0 -z-10 -translate-x-1/2 blur-3xl xl:-top-6" aria-hidden="true">
        <div
          className="aspect-[1155/678] w-[72.1875rem] bg-gradient-to-tr from-[#e4fc65] to-[#fcff53] opacity-30"
          style={{
            clipPath:
              'polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)',
          }}
        />
      </div>
    </div>
  )
}