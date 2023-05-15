import { FC, ReactNode } from "react";
import Footer from "./Footer";
import Header from "./Header";

interface Props {
    children: ReactNode
}
const Layout: FC<Props> = ({children}) => {
    return (
        <>
            <div className="bg-snow overflow-hidden flex flex-col min-h-screen">
            <Header />
                <div className="py-8 max-w-7xl w-full mx-auto space-y-8 sm:px-4 lg:px-4">
                    {children}
                </div>
            <Footer />
            </div>
        </>
    )
}

export default Layout;