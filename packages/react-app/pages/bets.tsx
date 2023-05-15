const stats = [
  { id: 1, name: 'Lakers', value: 'x1.8' },
  { id: 2, name: 'Total Amount', value: '$11,000' },
  { id: 3, name: 'Warriors', value: 'x5.40' },
]

export default function MyBets() {
  return (
    <div className="bg-slate flex flex-col items-center w-full flex-1 sm:py-8 px-8 text-center">
      <div className="w-full bg-white py-8 sm:py-12">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="flex flex-row gap-x-8 gap-y-16 text-center">
            <div className="mx-auto flex flex-col gap-y-4">
              <p className="text-base leading-7 text-gray-600">Lakers</p>
              <div className="order-first text-xl font-semibold tracking-tight text-gray-900 sm:text-3xl">
                x1.8
              </div>
            </div>
            <div className="mx-auto flex flex-col gap-y-4">
              <p className="text-base leading-7 text-gray-600">Total Amount</p>
              <div className="order-first text-xl font-semibold tracking-tight text-gray-900 sm:text-3xl">
                $11,000
              </div>
            </div>
            <div className="mx-auto flex flex-col gap-y-4">
              <p className="text-base leading-7 text-gray-600">Warriors</p>
              <div className="order-first text-xl font-semibold tracking-tight text-gray-900 sm:text-3xl">
                x5.40
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}