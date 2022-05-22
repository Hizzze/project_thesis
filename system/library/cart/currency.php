<?php
namespace Cart;
class Currency {
	public $currencies = array();

	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->language = $registry->get('language');

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency");

		foreach ($query->rows as $result) {
			$this->currencies[mb_strtolower($result['code'])] = array(
                'code' => $result['code'],
				'currency_id'   => $result['currency_id'],
				'title'         => $result['title'],
				'symbol_left'   => $result['symbol_left'],
				'symbol_right'  => $result['symbol_right'],
				'decimal_place' => $result['decimal_place'],
				'value'         => $result['value']
			);
		}
	}

	public function format($number, $currency, $value = '', $format = true) {
		$symbol_left = $this->currencies[mb_strtolower($currency)]['symbol_left'];
		$symbol_right = $this->currencies[mb_strtolower($currency)]['symbol_right'];
		$decimal_place = $this->currencies[mb_strtolower($currency)]['decimal_place'];

		if (!$value) {
			$value = $this->currencies[mb_strtolower($currency)]['value'];
		}

		$amount = $value ? (float)$number * $value : (float)$number;
		
		$amount = round($amount, (int)$decimal_place);
		
		if (!$format) {
			return $amount;
		}

		$string = '';

		if ($symbol_left) {
			$string .= $symbol_left;
		}

		$string .= number_format($amount, (int)$decimal_place, $this->language->get('decimal_point'), $this->language->get('thousand_point'));

		if ($symbol_right) {
			$string .= $symbol_right;
		}

		return $string;
	}

	public function convert($value, $from, $to) {
		if (isset($this->currencies[mb_strtolower($from)])) {
			$from = $this->currencies[mb_strtolower($from)]['value'];
		} else {
			$from = 1;
		}

		if (isset($this->currencies[mb_strtolower($to)])) {
			$to = $this->currencies[mb_strtolower($tto)]['value'];
		} else {
			$to = 1;
		}

		return $value * ($to / $from);
	}

    public function getId($currency) {
        if (isset($this->currencies[mb_strtolower($currency)])) {
            return $this->currencies[mb_strtolower($currency)]['currency_id'];
        } else {
            return 0;
        }
    }

    public function getCurrencies() {
        return $this->currencies;
    }

    public function get($currency) {
        if (isset($this->currencies[mb_strtolower($currency)])) {
            return $this->currencies[mb_strtolower($currency)];
        } else {
            return [];
        }
    }

	public function getSymbolLeft($currency) {
		if (isset($this->currencies[mb_strtolower($currency)])) {
			return $this->currencies[mb_strtolower($currency)]['symbol_left'];
		} else {
			return '';
		}
	}

	public function getSymbolRight($currency) {
		if (isset($this->currencies[mb_strtolower($currency)])) {
			return $this->currencies[mb_strtolower($currency)]['symbol_right'];
		} else {
			return '';
		}
	}

	public function getDecimalPlace($currency) {
		if (isset($this->currencies[mb_strtolower($currency)])) {
			return $this->currencies[mb_strtolower($currency)]['decimal_place'];
		} else {
			return 0;
		}
	}

	public function getValue($currency) {
		if (isset($this->currencies[mb_strtolower($currency)])) {
			return $this->currencies[mb_strtolower($currency)]['value'];
		} else {
			return 0;
		}
	}

	public function has($currency) {
		return isset($this->currencies[mb_strtolower($currency)]);
	}
}
