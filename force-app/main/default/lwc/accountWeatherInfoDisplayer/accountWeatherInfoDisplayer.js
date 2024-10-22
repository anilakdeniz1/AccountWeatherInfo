import { LightningElement, api, wire} from 'lwc';

import { ShowToastEvent } from 'lightning/platfromShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi'; 
import SHIPPING_CITY_FIELD from 'salesforce/schema/Account.ShippingCity';
import weatherCallout from '@salesforce/apex/AccountWeatherInfoController.weatherCallout';

export default class AccountWeatherInfoDisplayer extends LightningElement {
    @api recordId
    temperature
    description
    image
    locationName

    get title() {
        return `Weather in : ${this.locationName}`
    }

    get description() {
        return `Description : ${this.description}`
    }

    get temperature() {
        return `Temperature : ${this.temperature}`;
    }
    @wire( getRecord, { recordId: '$recordId', fields: [SHIPPING_CITY_FIELD]})
    accountRecordHandler(result) {
        const { data, error } = result
        if(data) {
            this.locationName = data.fields.ShippingCity.value
        }else if(error) {
            console.log(error.message)
        }
    }

    connectedCallback() {
        this.fetchWeatherData()
    }

    fetchWeatherData() {
        weatherCallout({ accountId: this.recordId})
        .then(result => {
            this.image = 'http://openweathermap.org/img/wn/'+result.weather[0].icon+'.png'
            this.description = result.weather[0].description
            this.temp = result.main.temp + 'C°'
        }).catch(error => {
            this.createToast('Error', 'There has been a problem\n Please check your Location \n Hint : Check shipping city of the account', 'sticky', 'error' )
            console.log('Error fetching data', error.message)
        })
    }

    createToast(title, message, mode, variant) {
        const toast = new ShowToastEvent({
            title,
            message,
            mode,
            variant: variant || 'success'
        })
        this.dispatchEvent(toast)
    }
}