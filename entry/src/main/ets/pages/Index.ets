import { DbHandler } from 'omc_db';
import { HomePage } from '../views/pages/HomePage';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    DbHandler.initDbData()
  }

  build() {
    RelativeContainer() {
      HomePage()
    }
  }
}